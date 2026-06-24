"""Flux 2 model lists, enums, and response models."""

from __future__ import annotations

from runapi.core import BaseModel, TaskResponse, optional, required


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
