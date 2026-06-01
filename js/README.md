# Flux API JavaScript SDK for RunAPI

The flux api JavaScript SDK is the language-specific package for Flux 2 on RunAPI. Use this flux api package for text-to-image, remix-image, and creative production flows when your application needs JSON request bodies, task status lookup, and consistent RunAPI errors in JavaScript.

This flux api README is the JavaScript package guide inside the public `flux-2-sdk` repository. For the repository overview, start at `../README.md`; for model details, use https://runapi.ai/models/flux-2; for API reference, use https://runapi.ai/docs#flux-2; for SDK docs, use https://runapi.ai/docs#sdk-flux-2.

## Install

```bash
npm install @runapi.ai/flux-2
```

## Quick start

```typescript
import { Flux2Client } from '@runapi.ai/flux-2';

const client = new Flux2Client();

const task = await client.textToImage.create({
  model: 'flux-2-pro-text-to-image',
  prompt: 'A cinematic product photo on warm paper',
  aspect_ratio: '1:1',
});
const status = await client.textToImage.get(task.id);

const remix = await client.remixImage.create({
  model: 'flux-2-pro-remix-image',
  prompt: 'Turn this product shot into a warm editorial photo',
  source_image_urls: ['https://example.com/source.jpg'],
  aspect_ratio: 'auto',
});
```

Use `create` when you want to submit a task and return quickly, `get` when you need the latest task state, and `run` when a script should create and poll until completion. In web request handlers, prefer `create` plus webhook or later `get` polling so a worker is not held open.

## Language notes

Use the TypeScript types in `src/types.ts` and the resource classes under `src/resources` when building image applications. The available resources include `textToImage` and `remixImage`. Keep `RUNAPI_API_KEY` in the environment or your secret manager; never commit API keys or callback secrets.

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
