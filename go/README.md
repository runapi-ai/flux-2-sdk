# Flux 2 API Go SDK for RunAPI

The Flux 2 Go SDK is the language-specific package for Flux 2 on RunAPI. Use this package for image generation, image editing, and creative production workflows when your application needs request bodies, task status lookup, and consistent RunAPI errors in Go.

This README is the Go package guide inside the public `flux-2-sdk` repository. For the repository overview, start at `../README.md`; for model details, use https://runapi.ai/models/flux-2; for API reference, use https://runapi.ai/docs#flux-2; for SDK docs, use https://runapi.ai/docs#sdk-flux-2.

## Install

```bash
go get github.com/runapi-ai/flux-2-sdk/go@latest
```

## Quick start

```go
import (
	"context"

	"github.com/runapi-ai/flux-2-sdk/go/flux2"
)

client, err := flux2.NewClient()
task, err := client.TextToImage.Create(context.Background(), flux2.TextToImageParams{
	Model: "flux-2-pro-text-to-image",
	Prompt: "A cinematic product photo on warm paper",
	AspectRatio: "1:1",
})
status, err := client.TextToImage.Get(context.Background(), task.ID)

remix, err := client.RemixImage.Create(context.Background(), flux2.RemixImageParams{
	Model: "flux-2-pro-remix-image",
	Prompt: "Turn this product shot into a warm editorial photo",
	SourceImageURLs: []string{"https://cdn.runapi.ai/public/samples/image.jpg"},
	AspectRatio: "auto",
})
```

Use `create` when you want to submit a task and return quickly, `get` when you need the latest task state, and `run` when a script should create and poll until completion. In web request handlers, prefer `create` plus webhook or later `get` polling so a worker is not held open.

RunAPI-generated file URLs are temporary. Download and store generated images, videos, audio, or other files in your own durable storage within 7 days; do not treat returned URLs as long-term assets.

## Language notes

Use the public Go module with `github.com/runapi-ai/core-sdk/go` options when building image services, CLIs, or workers. The available resources are `TextToImage` and `RemixImage`. Keep `RUNAPI_API_KEY` in the environment or your secret manager; never commit API keys or callback secrets.

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
