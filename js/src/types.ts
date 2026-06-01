import type { AsyncTaskStatus } from '@runapi.ai/core';

// Model types
export type Flux2Model =
  | 'flux-2-pro-text-to-image'
  | 'flux-2-pro-remix-image'
  | 'flux-2-flex-text-to-image'
  | 'flux-2-flex-remix-image';

// Aspect ratio for text-to-image
export type AspectRatio = '1:1' | '4:3' | '3:4' | '16:9' | '9:16' | '3:2' | '2:3';

// Aspect ratio for remix-image (includes 'auto')
export type RemixAspectRatio = AspectRatio | 'auto';

// Output resolution
export type OutputResolution = '1k' | '2k';

// Text-to-image generation params
export interface GenerationT2IParams {
  model: 'flux-2-pro-text-to-image' | 'flux-2-flex-text-to-image';
  prompt: string;
  callback_url?: string;
  output_resolution?: OutputResolution;
  enable_safety_checker?: boolean;
  aspect_ratio?: AspectRatio;
}

// Remix-image generation params
export interface RemixImageParams {
  model: 'flux-2-pro-remix-image' | 'flux-2-flex-remix-image';
  prompt: string;
  source_image_urls: string[];
  callback_url?: string;
  output_resolution?: OutputResolution;
  enable_safety_checker?: boolean;
  aspect_ratio?: RemixAspectRatio;
}

export type TextToImageParams = GenerationT2IParams;

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

export type RemixImageResponse = TextToImageResponse;
export type CompletedRemixImageResponse = CompletedTextToImageResponse;
