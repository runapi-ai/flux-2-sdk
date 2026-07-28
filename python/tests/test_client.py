import pytest

from runapi.core import config
from runapi.core.errors import AuthenticationError, ValidationError
from runapi.flux_2 import Flux2Client
from runapi.flux_2.resources.remix_image import RemixImage
from runapi.flux_2.resources.text_to_image import TextToImage
from runapi.flux_2.types import CompletedTextToImageResponse, TextToImageResponse


class FakeHttp:
    """Records (method, path, body) and replays preset responses by call order."""

    def __init__(self, *responses):
        self._responses = list(responses)
        self.calls = []

    def request(self, method, path, body=None, options=None):
        self.calls.append((method, path, body))
        if self._responses:
            return self._responses.pop(0)
        return {"id": "task_1", "status": "pending"}


@pytest.fixture(autouse=True)
def reset_config(monkeypatch):
    monkeypatch.delenv("RUNAPI_API_KEY", raising=False)
    monkeypatch.setattr(config, "api_key", None)
    yield


# --- authentication -------------------------------------------------------


def test_accepts_api_key_parameter():
    assert isinstance(Flux2Client(api_key="param-key", http_client=FakeHttp()), Flux2Client)


def test_falls_back_to_global(monkeypatch):
    monkeypatch.setattr(config, "api_key", "global-key")
    assert isinstance(Flux2Client(http_client=FakeHttp()), Flux2Client)


def test_falls_back_to_env(monkeypatch):
    monkeypatch.setenv("RUNAPI_API_KEY", "env-key")
    assert isinstance(Flux2Client(http_client=FakeHttp()), Flux2Client)


def test_raises_without_api_key():
    with pytest.raises(AuthenticationError, match="API key is required"):
        Flux2Client()


# --- transport injection / accessors --------------------------------------


def test_uses_injected_http_client():
    fake = FakeHttp()
    client = Flux2Client(api_key="k", http_client=fake)
    assert client.text_to_image._http is fake
    assert client.remix_image._http is fake


def test_exposes_resource_accessors():
    client = Flux2Client(api_key="k", http_client=FakeHttp())
    assert isinstance(client.text_to_image, TextToImage)
    assert isinstance(client.remix_image, RemixImage)


# --- request shapes -------------------------------------------------------


def test_create_posts_compacted_body():
    fake = FakeHttp({"id": "t1", "status": "pending"})
    client = Flux2Client(api_key="k", http_client=fake)
    result = client.text_to_image.create(
        model="flux-2-pro-text-to-image",
        prompt="hello",
        aspect_ratio="1:1",
        seed=None,
    )
    assert fake.calls == [
        ("post", "/api/v1/flux_2/text_to_image", {"model": "flux-2-pro-text-to-image", "prompt": "hello", "aspect_ratio": "1:1"}),
    ]
    assert isinstance(result, TextToImageResponse)
    assert result.id == "t1"


def test_get_fetches_by_id():
    fake = FakeHttp({"id": "t1", "status": "processing"})
    client = Flux2Client(api_key="k", http_client=fake)
    client.text_to_image.get("t1")
    assert fake.calls == [("get", "/api/v1/flux_2/text_to_image/t1", None)]


def test_run_polls_and_narrows_completed_type():
    fake = FakeHttp(
        {"id": "t1", "status": "pending"},
        {"id": "t1", "status": "completed", "images": [{"url": "https://x/y.png"}]},
    )
    client = Flux2Client(api_key="k", http_client=fake)
    result = client.text_to_image.run(model="flux-2-pro-text-to-image", prompt="sky")

    assert isinstance(result, CompletedTextToImageResponse)
    assert result.images[0].url == "https://x/y.png"
    assert [call[0] for call in fake.calls] == ["post", "get"]


# --- validation -----------------------------------------------------------


def test_create_requires_model():
    client = Flux2Client(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="model must be one of:"):
        client.text_to_image.create(prompt="hi")


def test_create_requires_prompt():
    client = Flux2Client(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="prompt is required"):
        client.text_to_image.create(model="flux-2-pro-text-to-image")


def test_create_rejects_unknown_model():
    client = Flux2Client(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="model must be one of:"):
        client.text_to_image.create(model="not-a-model", prompt="hi")


def test_create_rejects_invalid_enum():
    client = Flux2Client(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="aspect_ratio must be one of:"):
        client.text_to_image.create(model="flux-2-pro-text-to-image", prompt="hi", aspect_ratio="99:1")


def test_remix_requires_source_image_urls():
    client = Flux2Client(api_key="k", http_client=FakeHttp())
    with pytest.raises(ValidationError, match="source_image_urls is required"):
        client.remix_image.create(model="flux-2-pro-remix-image", prompt="sky")


def test_remix_accepts_auto_aspect_ratio():
    fake = FakeHttp({"id": "t1", "status": "pending"})
    client = Flux2Client(api_key="k", http_client=fake)
    client.remix_image.create(
        model="flux-2-pro-remix-image",
        prompt="sky",
        source_image_urls=["https://runapi.ai/a.jpg"],
        aspect_ratio="auto",
    )
    _, path, body = fake.calls[0]
    assert path == "/api/v1/flux_2/remix_image"
    assert body["aspect_ratio"] == "auto"


def test_max_models_require_their_constrained_request_shapes():
    fake = FakeHttp({"id": "max", "status": "pending"}, {"id": "max-remix", "status": "pending"})
    client = Flux2Client(api_key="k", http_client=fake)

    client.text_to_image.create(
        model="flux-2-max-text-to-image",
        prompt="A precise studio product photograph",
        aspect_ratio="4:3",
        output_resolution="1k",
        output_count=1,
    )
    client.remix_image.create(
        model="flux-2-max-remix-image",
        prompt="Refine the source product image",
        source_image_urls=["https://cdn.runapi.ai/public/samples/image.jpg"],
        aspect_ratio="3:4",
        output_resolution="1k",
        output_count=1,
    )

    assert fake.calls[0][2]["output_count"] == 1
    assert fake.calls[1][2]["source_image_urls"] == ["https://cdn.runapi.ai/public/samples/image.jpg"]


def test_max_text_to_image_requires_a_concrete_aspect_ratio():
    client = Flux2Client(api_key="k", http_client=FakeHttp())

    with pytest.raises(ValidationError, match="aspect_ratio is required"):
        client.text_to_image.create(model="flux-2-max-text-to-image", prompt="A precise studio product photograph")
