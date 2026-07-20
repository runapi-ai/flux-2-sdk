"""Flux 2 remix-image resource."""

from __future__ import annotations

from typing import Any, Optional

from runapi.core import Resource, RequestOptions

from ..contract_gen import CONTRACT
from ..types import (
    CompletedRemixImageResponse,
    RemixImageResponse,
)


class RemixImage(Resource):
    """Remix one or more source images into a new image with Flux 2 models."""

    ENDPOINT = "/api/v1/flux_2/remix_image"

    RESPONSE_CLASS = RemixImageResponse
    COMPLETED_RESPONSE_CLASS = CompletedRemixImageResponse

    def run(self, options: Optional[RequestOptions] = None, **params: Any) -> Any:
        """Create a remix-image task and poll until it completes.

        Args:
            **params: Remix-image parameters (model, prompt, ...).

        Returns:
            The completed remix-image response.
        """
        task = self.create(options=options, **params)
        return self._poll_until_complete(lambda: self.get(task.id, options=options))

    def create(self, options: Optional[RequestOptions] = None, **params: Any) -> Any:
        """Create a remix-image task and return immediately with an id.

        Args:
            **params: Remix-image parameters (model, prompt, ...).

        Returns:
            The task creation result with an id.
        """
        compacted = self._compact_params(params)
        self._validate_contract(CONTRACT["remix-image"], compacted)
        return self._request("post", self.ENDPOINT, body=compacted, options=options)

    def get(self, id: str, options: Optional[RequestOptions] = None) -> Any:
        """Fetch the current status of a remix-image task.

        Args:
            id: Task id.

        Returns:
            The current remix-image status.
        """
        return self._request("get", f"{self.ENDPOINT}/{id}", options=options)
