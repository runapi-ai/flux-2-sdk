import type { AsyncTaskStatus } from '@runapi.ai/core';

// Model types
export type Flux2Model =
  | 'flux-2-pro-text-to-image'
  | 'flux-2-pro-image-to-image'
  | 'flux-2-flex-text-to-image'
  | 'flux-2-flex-image-to-image';

// Aspect ratio for text-to-image
export type AspectRatio = '1:1' | '4:3' | '3:4' | '16:9' | '9:16' | '3:2' | '2:3';

// Aspect ratio for image-to-image (includes 'auto')
export type AspectRatioI2I = AspectRatio | 'auto';

// Resolution
export type Resolution = '1K' | '2K';

// Text-to-image generation params
export interface GenerationT2IParams {
  model: 'flux-2-pro-text-to-image' | 'flux-2-flex-text-to-image';
  prompt: string;
  callback_url?: string;
  resolution?: Resolution;
  nsfw_checker?: boolean;
  aspect_ratio?: AspectRatio;
}

// Image-to-image generation params
export interface GenerationI2IParams {
  model: 'flux-2-pro-image-to-image' | 'flux-2-flex-image-to-image';
  prompt: string;
  input_urls: string[];
  callback_url?: string;
  resolution?: Resolution;
  nsfw_checker?: boolean;
  aspect_ratio?: AspectRatioI2I;
}

export type TextToImageParams = GenerationT2IParams | GenerationI2IParams;

// Response types
export interface TaskCreateResponse {
  id: string;
}

export interface Image {
  url: string;
}

export interface TextToImageResponse {
  id: string;
  status: AsyncTaskStatus;
  images?: Image[];
  error?: string;
  [key: string]: unknown;
}

/**
 * Resolved response returned by `textToImage.run()` after polling sees
 * `status: 'completed'`. Narrows the base response so `images` is guaranteed
 * non-optional in user code.
 */
export type CompletedTextToImageResponse = TextToImageResponse & {
  status: 'completed';
  images: Image[];
};
