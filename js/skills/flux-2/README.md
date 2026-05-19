# Flux 2 API Skill for RunAPI

Generate images with Flux 2 Pro and Flex text-to-image and image-to-image. This skill helps Claude Code, Codex, Gemini CLI, Cursor, and 50+ agents integrate Flux 2 through RunAPI.

The canonical agent file is `skills/flux-2/SKILL.md`.

## Install

```bash
npx skills add runapi-ai/flux2 -g
```

Or manually: clone this repo and copy `skills/flux-2/` into your agent's skills directory.

## Quick example

```typescript
import { Flux2Client } from '@runapi.ai/flux-2';

const client = new Flux2Client();
const result = await client.textToImage.run({
  model: 'flux-2-pro-text-to-image',
  prompt: 'A cinematic product photo on warm paper',
  aspect_ratio: '1:1',
});
```

## Routing

- Model page: https://runapi.ai/models/flux-2
- Product docs: https://runapi.ai/docs#flux-2
- SDK docs: https://runapi.ai/docs#sdk-flux-2
- SDK repository: https://github.com/runapi-ai/flux-2-sdk
- Pricing and rate limits: https://runapi.ai/models/flux-2/pro-text-to-image
- Provider comparison: https://runapi.ai/providers/black-forest-labs
- Browse all RunAPI models and skills: https://runapi.ai/models

## Variants

- [Flux 2 Pro text to image](https://runapi.ai/models/flux-2/pro-text-to-image)
- [Flux 2 Pro image to image](https://runapi.ai/models/flux-2/pro-image-to-image)
- [Flux 2 Flex text to image](https://runapi.ai/models/flux-2/flex-text-to-image)
- [Flux 2 Flex image to image](https://runapi.ai/models/flux-2/flex-image-to-image)

## Agent rules

- Keep API keys in `RUNAPI_API_KEY` or RunAPI CLI config; never commit secrets.
- Prefer `create`, `get`, and `run` JSON passthrough patterns instead of inventing flags for every model parameter.
- For flux api pricing, rate-limit, and commercial-usage answers, link to the variant page rather than the repository README.

## License

Licensed under the Apache License, Version 2.0.
