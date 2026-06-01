<p align="center">
  <a href="https://runapi.ai"><img src="https://runapi.ai/icon.svg" height="56" alt="RunAPI"></a>
</p>

<h3 align="center">
  <a href="https://github.com/runapi-ai/flux-2-sdk">Flux 2 API SDK for RunAPI</a>
</h3>

<p align="center">
  Flux 2 API SDKs for JavaScript, Ruby, and Go on RunAPI.
</p>

<div align="center">

[![npm](https://img.shields.io/npm/v/@runapi.ai/flux-2)](https://www.npmjs.com/package/@runapi.ai/flux-2)
[![RubyGems](https://img.shields.io/gem/v/runapi-flux-2)](https://rubygems.org/gems/runapi-flux-2)
[![Go Reference](https://pkg.go.dev/badge/github.com/runapi-ai/flux-2-sdk/go.svg)](https://pkg.go.dev/github.com/runapi-ai/flux-2-sdk/go)
[![License](https://img.shields.io/github/license/runapi-ai/flux-2-sdk)](https://github.com/runapi-ai/flux-2-sdk/blob/main/LICENSE)

</div>
<br/>

The flux api SDK packages JavaScript, Ruby, and Go clients for Flux 2 on RunAPI. Use this flux api SDK for text-to-image, remix-image, and creative production workflows that need typed installs, JSON request bodies, task polling, and consistent RunAPI errors across services.

Flux 2 belongs to the Black Forest Labs catalog on RunAPI. The public model page is https://runapi.ai/models/flux-2; variant pages below carry pricing, rate-limit, and commercial-usage details. The public `flux-2-sdk` repository groups the JavaScript, Ruby, and Go packages for this model.

## Install

```bash
npm install @runapi.ai/flux-2
gem install runapi-flux-2
go get github.com/runapi-ai/flux-2-sdk/go@latest
```

## What you can build

- Build product imagery, creative automation, design previews, and agent image workflows with the flux api SDK.
- Keep one model-specific repository while installing only the language package your app needs.
- Use `create` for submit-only jobs, `get` for status lookup, and `run` for submit-and-poll scripts.
- Handle authentication, validation, rate limits, insufficient credits, task failures, and polling timeouts through RunAPI SDK errors.

The JavaScript client exposes `textToImage` and `remixImage` resources, and the Ruby and Go packages mirror the same RunAPI task lifecycle.

## JavaScript quick start

```typescript
import { Flux2Client } from '@runapi.ai/flux-2';

const client = new Flux2Client();

const task = await client.textToImage.create({
  model: 'flux-2-pro-text-to-image',
  prompt: 'A cinematic product photo on warm paper',
});

const status = await client.textToImage.get(task.id);
```

```typescript
const remix = await client.remixImage.create({
  model: 'flux-2-pro-remix-image',
  prompt: 'Turn this product shot into a warm editorial photo',
  source_image_urls: ['https://example.com/source.jpg'],
  aspect_ratio: 'auto',
});
```

For short scripts, use `run` with the same JSON body to create the task and wait for completion. For web request handlers, prefer `create` plus webhook or later `get` polling so the server does not hold a worker open.

## Repository layout

- `js/` publishes `@runapi.ai/flux-2`.
- `ruby/` publishes `runapi-flux-2` when RubyGems publishing resumes.
- `go/` publishes `github.com/runapi-ai/flux-2-sdk/go` and depends on `github.com/runapi-ai/core-sdk/go`.

## Public links

- Model page: https://runapi.ai/models/flux-2
- SDK docs: https://runapi.ai/docs#sdk-flux_2
- Product docs: https://runapi.ai/docs#flux_2
- SDK repository: https://github.com/runapi-ai/flux-2-sdk
- Skill repository: https://github.com/runapi-ai/flux2
- Provider comparison: https://runapi.ai/providers/black-forest-labs
- Full catalog: https://runapi.ai/models

## Pricing and variants

Use the most specific flux api variant page for pricing, rate limits, and commercial usage:
- [Flux 2 Pro text to image](https://runapi.ai/models/flux-2/pro-text-to-image)
- [Flux 2 Pro remix image](https://runapi.ai/models/flux-2/pro-remix-image)
- [Flux 2 Flex text to image](https://runapi.ai/models/flux-2/flex-text-to-image)
- [Flux 2 Flex remix image](https://runapi.ai/models/flux-2/flex-remix-image)

Default pricing link for the flux api SDK: https://runapi.ai/models/flux-2/pro-text-to-image

## FAQ

### Which package should I install for flux api work?

Install the model package for your language: `@runapi.ai/flux-2`, `runapi-flux-2`, or `github.com/runapi-ai/flux-2-sdk/go`. Install core SDK packages only when you are building shared SDK infrastructure.

### Where should public links point?

Primary flux api links point to https://runapi.ai/models/flux-2. Pricing and usage-policy links point to variant pages such as https://runapi.ai/models/flux-2/pro-text-to-image. Provider comparisons point to https://runapi.ai/providers/black-forest-labs, and broad browsing points to https://runapi.ai/models.

## License

Licensed under the Apache License, Version 2.0.
