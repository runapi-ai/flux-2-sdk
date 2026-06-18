import { BaseClient, type ClientOptions } from '@runapi.ai/core';
import { TextToImage } from './resources/text-to-image';
import { RemixImage } from './resources/remix-image';

/**
 * Flux 2 text-to-image and remix API client.
 *
 * Pro and flex tiers for both text-to-image generation and
 * text-guided image remixing from source images.
 *
 * @example
 * ```typescript
 * const client = new Flux2Client({
 *   apiKey: 'your-api-key',
 *   baseUrl: 'https://runapi.ai',
 * });
 *
 * const result = await client.textToImage.run({
 *   model: 'flux-2-pro-text-to-image',
 *   prompt: 'A futuristic cityscape at night',
 * });
 * ```
 */
export class Flux2Client extends BaseClient {
  /** Text-to-image generation. */
  public readonly textToImage: TextToImage;
  /** Transform source images with text-guided prompts. */
  public readonly remixImage: RemixImage;

  constructor(options: ClientOptions = {}) {
    super(options);
    this.textToImage = new TextToImage(this.http);
    this.remixImage = new RemixImage(this.http);
  }
}
