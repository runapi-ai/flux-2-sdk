# Flux 2 API Python SDK for RunAPI

The Flux 2 Python SDK is the language-specific package for Flux 2 on RunAPI. Use this package for image generation, image editing, and creative production workflows when your application needs request bodies, task status lookup, and consistent RunAPI errors in Python.

This README is the Python package guide inside the public `flux-2-sdk` repository. For the repository overview, start at `../README.md`; for model details, use https://runapi.ai/models/flux-2; for API reference, use https://runapi.ai/docs#flux-2; for SDK docs, use https://runapi.ai/docs#sdk-flux-2.

## Install

```bash
pip install runapi-flux-2
```

## Quick start

```python
from runapi.flux_2 import Flux2Client

client = Flux2Client()  # reads RUNAPI_API_KEY, or pass api_key="sk-..."

task = client.text_to_image.create(
    model="flux-2-pro-text-to-image",
    prompt="A cinematic product photo on warm paper",
    aspect_ratio="1:1",
)
status = client.text_to_image.get(task.id)

remix = client.remix_image.create(
    model="flux-2-pro-remix-image",
    prompt="Turn this product shot into a warm editorial photo",
    source_image_urls=["https://cdn.runapi.ai/public/samples/image.jpg"],
    aspect_ratio="auto",
)
```

Use `create` when you want to submit a task and return quickly, `get` when you need the latest task state, and `run` when a script should create and poll until completion:

```python
result = client.text_to_image.run(
    model="flux-2-pro-text-to-image",
    prompt="A futuristic cityscape at dusk",
)
print(result.images[0].url)
```

In web request handlers, prefer `create` plus webhook or later `get` polling so a worker is not held open.

## Flux 2 Max

Use `flux-2-max-text-to-image` or `flux-2-max-remix-image` for the highest-quality tier. Max requires a concrete `aspect_ratio`, supports `output_resolution="1k"` and `output_count=1` only, and accepts exactly one public HTTP(S) source image for remix.

RunAPI-generated file URLs are temporary. Download and store generated images, videos, audio, or other files in your own durable storage within 7 days; do not treat returned URLs as long-term assets.

## Language notes

Pass parameters as keyword arguments and catch the `runapi.flux_2` error classes when building image jobs or scripts. The available resources are `text_to_image` and `remix_image`. Keep `RUNAPI_API_KEY` in the environment or your secret manager; never commit API keys or callback secrets.

## Links

- Model page: https://runapi.ai/models/flux-2
- SDK docs: https://runapi.ai/docs#sdk-flux-2
- Product docs: https://runapi.ai/docs#flux-2
- Pricing and rate limits: https://runapi.ai/models/flux-2/pro-text-to-image
- Provider comparison: https://runapi.ai/providers/black-forest-labs
- Full catalog: https://runapi.ai/models
- Repository: https://github.com/runapi-ai/flux-2-sdk

## License

Licensed under the Apache License, Version 2.0.
