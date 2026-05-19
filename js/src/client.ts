import { createHttpClient, type ClientOptions } from '@runapi.ai/core';
import { TextToImage } from './resources/text-to-image';

/**
 * Flux 2 text-to-image API client.
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
export class Flux2Client {
  /** Text-to-image operations. */
  public readonly textToImage: TextToImage;

  constructor(options: ClientOptions = {}) {
    const http = createHttpClient(options);
    this.textToImage = new TextToImage(http);
  }
}
