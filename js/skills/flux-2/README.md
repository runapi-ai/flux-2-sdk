<p align="center">
  <a href="https://github.com/runapi-ai/flux-2">
    <h3 align="center">Flux 2 API Skill for RunAPI</h3>
  </a>
</p>

<p align="center">
  Install this agent skill, inspect Flux 2 fields, then run jobs through the RunAPI CLI.
</p>

<p align="center">
  <a href="https://runapi.ai/models/flux-2"><strong>Model Reference</strong></a> · <a href="https://github.com/runapi-ai/cli"><strong>CLI</strong></a> · <a href="https://github.com/runapi-ai/flux-2-sdk"><strong>SDK</strong></a>
</p>

<div align="center">

[![skills.sh](https://www.skills.sh/b/runapi-ai/flux-2)](https://www.skills.sh/runapi-ai/flux-2/flux-2)
[![ClawHub](https://img.shields.io/badge/ClawHub-runapi--flux--2-111827)](https://clawhub.ai/runapi-ai/runapi-flux-2)
[![License](https://img.shields.io/github/license/runapi-ai/flux-2)](https://github.com/runapi-ai/flux-2/blob/main/LICENSE)

</div>
<br/>

Generate and remix images with Flux 2 Pro and Flex. This skill helps Claude Code, Codex, Gemini CLI, Cursor, and 50+ agents integrate Flux 2 through RunAPI.

The canonical agent file is `skills/flux-2/SKILL.md`.

## Install

```bash
npx skills add runapi-ai/flux-2 -g
```

Or paste this prompt to your AI agent:

```text
Install the flux-2 skill for me:

1. Clone https://github.com/runapi-ai/flux-2
2. Copy the skills/flux-2/ directory into your
   user-level skills directory (e.g. ~/.claude/skills/
   for Claude Code, ~/.codex/skills/ for Codex).
3. Verify that SKILL.md is present.
4. Confirm the install path when done.
```

## Quick example

```typescript
import { Flux2Client } from '@runapi.ai/flux-2';

const client = new Flux2Client();
const result = await client.textToImage.run({
  model: 'flux-2-pro-text-to-image',
  prompt: 'A cinematic product photo on warm paper',
  aspect_ratio: '1:1',
});

const remix = await client.remixImage.run({
  model: 'flux-2-pro-remix-image',
  prompt: 'Make this product shot feel like a warm editorial photo',
  source_image_urls: ['https://example.com/source.jpg'],
  aspect_ratio: 'auto',
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
- [Flux 2 Pro remix image](https://runapi.ai/models/flux-2/pro-remix-image)
- [Flux 2 Flex text to image](https://runapi.ai/models/flux-2/flex-text-to-image)
- [Flux 2 Flex remix image](https://runapi.ai/models/flux-2/flex-remix-image)

## Agent rules

- Integration work uses the target language SDK; one-off generation, manual smoke tests, debugging, or user-requested CLI runs use the RunAPI CLI skill: https://github.com/runapi-ai/cli-skill
- RunAPI-generated file URLs are temporary. Download and store generated images, videos, audio, or other files in your own durable storage within 7 days; do not treat returned URLs as long-term assets.
- Keep API keys in `RUNAPI_API_KEY` or RunAPI CLI config; never commit secrets.
- Prefer `create`, `get`, and `run` JSON passthrough patterns instead of inventing flags for every model parameter.
- For flux api pricing, rate-limit, and commercial-usage answers, link to the variant page rather than the repository README.

## License

Licensed under the Apache License, Version 2.0.
