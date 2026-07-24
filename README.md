<p align="center">
  <a href="https://runapi.ai"><img src="https://runapi.ai/icon.svg" height="56" alt="RunAPI"></a>
</p>

<h3 align="center">
  <a href="https://github.com/runapi-ai/flux-2-sdk">Flux 2 API SDK for RunAPI</a>
</h3>

<p align="center">
  Flux 2 API SDKs for JavaScript, Python, Ruby, Go, Java, and PHP on RunAPI.
</p>

<div align="center">

[![npm](https://img.shields.io/npm/v/@runapi.ai/flux-2)](https://www.npmjs.com/package/@runapi.ai/flux-2)
[![PyPI](https://img.shields.io/pypi/v/runapi-flux-2)](https://pypi.org/project/runapi-flux-2/)
[![RubyGems](https://img.shields.io/gem/v/runapi-flux-2)](https://rubygems.org/gems/runapi-flux-2)
[![Go Reference](https://pkg.go.dev/badge/github.com/runapi-ai/flux-2-sdk/go.svg)](https://pkg.go.dev/github.com/runapi-ai/flux-2-sdk/go)
[![Maven Central](https://img.shields.io/maven-central/v/ai.runapi/runapi-flux-2)](https://central.sonatype.com/artifact/ai.runapi/runapi-flux-2)
[![License](https://img.shields.io/github/license/runapi-ai/flux-2-sdk)](https://github.com/runapi-ai/flux-2-sdk/blob/main/LICENSE)

</div>
<br/>

The Flux 2 API SDK packages JavaScript, Python, Ruby, Go, Java, and PHP clients for Flux 2 on RunAPI. Use it for text-to-image and remix-image workflows when your app needs typed request builders, predictable task polling, file upload helpers, account helpers, and consistent RunAPI errors.

Flux 2 is listed in the RunAPI model catalog at https://runapi.ai/models/flux-2. Variant pages below carry pricing, rate-limit, and commercial-usage details. The public `flux-2-sdk` repository groups the non-PHP language packages, examples, CI, and release tags for this model. The PHP package is released from a split Composer repository.

## Install

```bash
npm install @runapi.ai/flux-2
pip install runapi-flux-2
gem install runapi-flux-2
go get github.com/runapi-ai/flux-2-sdk/go@latest
```

Gradle:

```kotlin
dependencies {
  implementation("ai.runapi:runapi-flux-2:0.1.1")
}
```

Maven:

```xml
<dependency>
  <groupId>ai.runapi</groupId>
  <artifactId>runapi-flux-2</artifactId>
  <version>0.1.1</version>
</dependency>
```

Use the Java BOM when installing multiple RunAPI Java modules:

```kotlin
dependencies {
  implementation(platform("ai.runapi:runapi-bom:0.2.6"))
  implementation("ai.runapi:runapi-flux-2")
}
```

The PHP package is published from the split Composer repository as `runapi-ai/flux-2`; see https://github.com/runapi-ai/flux-2-php for PHP install and examples.

## What you can build

- Build apps, agent workflows, batch jobs, and production services around Flux 2 requests.
- Install only the language package your app needs while keeping one model-specific repository for docs and releases.
- Use `create` for submit-only jobs, `get` for status lookup, and `run` for submit-and-poll scripts.
- Upload local files, URL files, or base64 files through shared RunAPI file helpers.
- Handle validation, authentication, rate limits, insufficient credits, task failures, and polling timeouts through RunAPI SDK errors.

## Java quick start

```java
import ai.runapi.flux2.Flux2Client;
import ai.runapi.flux2.types.TextToImageParams;
import ai.runapi.flux2.types.CompletedTextToImageResponse;
import ai.runapi.flux2.types.TextToImageModel;

Flux2Client client = Flux2Client.builder()
    .apiKey(System.getenv("RUNAPI_API_KEY"))
    .build();

CompletedTextToImageResponse result = client.textToImage().run(
    TextToImageParams.builder()
        .model(TextToImageModel.FLUX_2_FLEX_TEXT_TO_IMAGE)
        .prompt("A futuristic greenhouse in the desert at sunrise")
        .aspectRatio("16:9")
        .outputResolution("1k")
        .build()
);
```

Java packages target Java 8 bytecode and are tested on Java 8, 11, 17, and 21. Each model artifact depends on `ai.runapi:runapi-core`, so application code normally installs only `ai.runapi:runapi-flux-2`.

## Task lifecycle

Most media endpoints are asynchronous. `create()` submits a task and returns its id, `get(id)` fetches the latest task state, and `run(params)` creates the task and polls until it reaches a terminal state. In web request handlers, prefer `create()` plus webhook or later `get()` polling so the server does not hold a worker open.

## Repository layout

- `js/` publishes `@runapi.ai/flux-2`.
- `python/` publishes `runapi-flux-2`.
- `ruby/` publishes `runapi-flux-2`.
- `go/` publishes `github.com/runapi-ai/flux-2-sdk/go` and depends on `github.com/runapi-ai/core-sdk/go`.
- `java/` publishes `ai.runapi:runapi-flux-2` and depends on `ai.runapi:runapi-core`.

## Public links

- Model page: https://runapi.ai/models/flux-2
- SDK docs: https://runapi.ai/docs#sdk-flux-2
- Product docs: https://runapi.ai/docs#flux-2
- SDK repository: https://github.com/runapi-ai/flux-2-sdk
- PHP package repository: https://github.com/runapi-ai/flux-2-php
- Skill repository: https://github.com/runapi-ai/flux-2
- Provider comparison: https://runapi.ai/providers/black-forest-labs
- Full catalog: https://runapi.ai/models

## Pricing and variants

Use the most specific Flux 2 variant page for pricing, rate limits, and commercial usage:
- [Flux 2 Pro text to image](https://runapi.ai/models/flux-2/pro-text-to-image)
- [Flux 2 Pro remix image](https://runapi.ai/models/flux-2/pro-remix-image)
- [Flux 2 Flex text to image](https://runapi.ai/models/flux-2/flex-text-to-image)
- [Flux 2 Flex remix image](https://runapi.ai/models/flux-2/flex-remix-image)

Default pricing link for the Flux 2 SDK: https://runapi.ai/models/flux-2/pro-text-to-image

## File storage

RunAPI-generated file URLs are temporary. Download and store generated images, videos, audio, or other files in your own durable storage within 7 days; do not treat returned URLs as long-term assets.

## FAQ

### Which package should I install for Flux 2 work?

Install the model package for your language: `@runapi.ai/flux-2` on npm, `runapi-flux-2` on PyPI, `runapi-flux-2` on RubyGems, `github.com/runapi-ai/flux-2-sdk/go`, `ai.runapi:runapi-flux-2` on Maven Central, or `runapi-ai/flux-2` on Packagist. Install core SDK packages only when you are building shared SDK infrastructure.

### Where should public links point?

Primary Flux 2 links point to https://runapi.ai/models/flux-2. Pricing and usage-policy links point to variant pages such as https://runapi.ai/models/flux-2/pro-text-to-image. Provider comparisons point to https://runapi.ai/providers/black-forest-labs, and broad browsing points to https://runapi.ai/models.

## License

Licensed under the Apache License, Version 2.0.
