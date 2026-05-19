---
name: flux-2
description: Generate images with Flux 2 Pro/Flex text-to-image and image-to-image through RunAPI.ai using the @runapi.ai/flux-2 Node/TypeScript SDK. Use when the user asks to add Flux 2 image generation or writes against @runapi.ai/flux-2. Triggers on "flux2", "flux 2", "image generation", "生成图片", "@runapi.ai/flux-2".
documentation: https://runapi.ai/models/flux-2
provider_page: https://runapi.ai/providers/black-forest-labs
catalog: https://runapi.ai/models
---
# @runapi.ai/flux-2 — RunAPI.ai Flux 2 image generation

Use `Flux2Client` for Flux 2 image tasks.

```ts
import { Flux2Client } from '@runapi.ai/flux-2';

const client = new Flux2Client({ apiKey: process.env.RUNAPI_API_KEY });

const result = await client.textToImage.run({
  model: 'flux-2-pro-text-to-image',
  prompt: 'A cinematic product photo on warm paper',
  aspect_ratio: '1:1',
});
```
