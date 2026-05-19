# Flux API Go SDK for RunAPI

The flux api Go SDK is the language-specific package for Flux 2 on RunAPI. Use this flux api package for text-to-image, image-to-image, edit, and creative production flows when your application needs JSON request bodies, task status lookup, and consistent RunAPI errors in Go.

This flux api README is the Go package guide inside the public `flux2-sdk` repository. For the repository overview, start at `../README.md`; for model details, use https://runapi.ai/models/flux-2; for API reference, use https://runapi.ai/docs#flux-2; for SDK docs, use https://runapi.ai/docs#sdk-flux-2.

## Install

```bash
go get github.com/runapi-ai/flux2-sdk/go@latest
```

## Quick start

```go
import (
  "context"

  "github.com/runapi-ai/flux2-sdk/go/flux2"
)

client, err := flux2.NewClient()
task, err := client.Generations.Create(context.Background(), flux2.GenerationParams{
  // Pass the Flux 2 JSON request body from https://runapi.ai/docs#flux-2.
})
status, err := client.Generations.Get(context.Background(), task.ID)
```

Use `create` when you want to submit a task and return quickly, `get` when you need the latest task state, and `run` when a script should create and poll until completion. In web request handlers, prefer `create` plus webhook or later `get` polling so a worker is not held open.

## Language notes

Use the public Go module with `github.com/runapi-ai/core-sdk/go` options when building image services, CLIs, or workers. The available resources include generations. Keep `RUNAPI_API_KEY` in the environment or your secret manager; never commit API keys or callback secrets.

## Links

- Model page: https://runapi.ai/models/flux-2
- SDK docs: https://runapi.ai/docs#sdk-flux-2
- Product docs: https://runapi.ai/docs#flux-2
- Pricing and rate limits: https://runapi.ai/models/flux-2/pro-text-to-image
- Provider comparison: https://runapi.ai/providers/black-forest-labs
- Full catalog: https://runapi.ai/models
- Repository: https://github.com/runapi-ai/flux2-sdk

## License

Licensed under the Apache License, Version 2.0.
