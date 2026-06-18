"""Flux 2 remix-image resource."""

from __future__ import annotations

from typing import Any, Dict

from runapi.core import Resource, ValidationError

from ..types import (
    OUTPUT_RESOLUTIONS,
    REMIX_ASPECT_RATIOS,
    REMIX_MODELS,
    CompletedRemixImageResponse,
    RemixImageResponse,
)


class RemixImage(Resource):
    """Remix one or more source images into a new image with Flux 2 models."""

    ENDPOINT = "/api/v1/flux_2/remix_image"

    RESPONSE_CLASS = RemixImageResponse
    COMPLETED_RESPONSE_CLASS = CompletedRemixImageResponse

    def run(self, **params: Any) -> Any:
        """Create a remix-image task and poll until it completes.

        Args:
            **params: Remix-image parameters (model, prompt, ...).

        Returns:
            The completed remix-image response.
        """
        task = self.create(**params)
        return self._poll_until_complete(lambda: self.get(task.id))

    def create(self, **params: Any) -> Any:
        """Create a remix-image task and return immediately with an id.

        Args:
            **params: Remix-image parameters (model, prompt, ...).

        Returns:
            The task creation result with an id.
        """
        compacted = self._compact_params(params)
        self._validate_params(compacted)
        return self._request("post", self.ENDPOINT, body=compacted)

    def get(self, id: str) -> Any:
        """Fetch the current status of a remix-image task.

        Args:
            id: Task id.

        Returns:
            The current remix-image status.
        """
        return self._request("get", f"{self.ENDPOINT}/{id}")

    def _validate_params(self, params: Dict[str, Any]) -> None:
        model = params.get("model")
        if not model:
            raise ValidationError("model is required")
        if model not in REMIX_MODELS:
            joined = ", ".join(REMIX_MODELS)
            raise ValidationError(f"Invalid model: {model}. Must be one of: {joined}")

        if not params.get("prompt"):
            raise ValidationError("prompt is required")

        self._validate_optional(params, "aspect_ratio", REMIX_ASPECT_RATIOS)
        self._validate_optional(params, "output_resolution", OUTPUT_RESOLUTIONS)

        urls = params.get("source_image_urls")
        if not urls:
            raise ValidationError("source_image_urls is required")
