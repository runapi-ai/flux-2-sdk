"""Flux 2 client."""

from __future__ import annotations

from typing import Any, Optional

from runapi.core import ProviderClient

from .resources.remix_image import RemixImage
from .resources.text_to_image import TextToImage


class Flux2Client(ProviderClient):
    """Flux 2 text-to-image and remix-image client.

    Example::

        client = Flux2Client(api_key="sk-...")
        result = client.text_to_image.run(
            model="flux-2-pro-text-to-image", prompt="A futuristic cityscape"
        )
    """

    def __init__(self, api_key: Optional[str] = None, **options: Any) -> None:
        super().__init__(api_key, **options)
        http = self._http
        self.text_to_image = TextToImage(http)
        self.remix_image = RemixImage(http)
