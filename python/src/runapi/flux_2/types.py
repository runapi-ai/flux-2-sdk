"""Flux 2 model lists, enums, and response models."""

from __future__ import annotations

from runapi.core import BaseModel, TaskResponse, optional, required

MODELS = [
    "flux-2-pro-text-to-image",
    "flux-2-pro-remix-image",
    "flux-2-flex-text-to-image",
    "flux-2-flex-remix-image",
]
TEXT_TO_IMAGE_MODELS = ["flux-2-pro-text-to-image", "flux-2-flex-text-to-image"]
REMIX_MODELS = ["flux-2-pro-remix-image", "flux-2-flex-remix-image"]

ASPECT_RATIOS = ["1:1", "4:3", "3:4", "16:9", "9:16", "3:2", "2:3"]
REMIX_ASPECT_RATIOS = ["1:1", "4:3", "3:4", "16:9", "9:16", "3:2", "2:3", "auto"]
OUTPUT_RESOLUTIONS = ["1k", "2k"]


class Image(BaseModel):
    url = optional(str)


class TextToImageResponse(TaskResponse):
    """Task status/result for Flux 2 text-to-image."""
    id = required(str)
    status = optional(str, enum=lambda: TaskResponse.Status.ALL)
    images = optional([lambda: Image])
    error = optional(str)


class CompletedTextToImageResponse(TextToImageResponse):
    """Returned by ``text_to_image.run()`` once polling observes completion.

    ``images`` is required so callers never have to null-check it on success.
    """

    images = required([lambda: Image])


class RemixImageResponse(TextToImageResponse):
    """Task status/result for Flux 2 remix-image."""
    pass


class CompletedRemixImageResponse(CompletedTextToImageResponse):
    pass
