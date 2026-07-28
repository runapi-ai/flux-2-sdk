import type { AsyncTaskStatus, TaskBillingResponse, TaskResponse } from '@runapi.ai/core';

/**
 * All Flux 2 model slugs. Pro and Flex offer their standard request shapes;
 * Max is the highest-quality tier with a focused 1k contract.
 */
export type Flux2Model =
  | 'flux-2-pro-text-to-image'
  | 'flux-2-pro-remix-image'
  | 'flux-2-flex-text-to-image'
  | 'flux-2-flex-remix-image'
  | 'flux-2-max-text-to-image'
  | 'flux-2-max-remix-image';

/** Output aspect ratio for text-to-image generation. */
export type AspectRatio = '1:1' | '4:3' | '3:4' | '16:9' | '9:16' | '3:2' | '2:3';

/** Aspect ratios for remix, including 'auto' to preserve the source image ratio. */
export type RemixAspectRatio = AspectRatio | 'auto';

/** Output resolution tier for Flux 2 generation (max 2k). */
export type OutputResolution = '1k' | '2k';

/** Parameters for Flux 2 Pro and Flex text-to-image generation. */
export interface ProFlexGenerationT2IParams {
  model: 'flux-2-pro-text-to-image' | 'flux-2-flex-text-to-image';
  /** Text description of desired image, 3-5000 characters. */
  prompt: string;
  /** URL for completion callback notifications. */
  callback_url?: string;
  /** Default: 1k. */
  output_resolution?: OutputResolution;
  /** Content safety check toggle. */
  enable_safety_checker?: boolean;
  /** Default: 1:1. */
  aspect_ratio?: AspectRatio;
}

/** Parameters for Flux 2 Max text-to-image generation. */
export interface MaxGenerationT2IParams {
  model: 'flux-2-max-text-to-image';
  /** Text description of desired image, 3-5000 characters. */
  prompt: string;
  /** URL for completion callback notifications. */
  callback_url?: string;
  /** Max supports only 1k output. */
  output_resolution?: '1k';
  /** Max produces exactly one image. */
  output_count?: 1;
  /** A concrete output aspect ratio is required for Max. */
  aspect_ratio: AspectRatio;
}

/** Parameters for Flux 2 text-to-image generation. */
export type GenerationT2IParams = ProFlexGenerationT2IParams | MaxGenerationT2IParams;

/**
 * Parameters for Flux 2 Pro and Flex image remix.
 * Transforms source images guided by a text prompt.
 */
export interface ProFlexRemixImageParams {
  model: 'flux-2-pro-remix-image' | 'flux-2-flex-remix-image';
  /** Text description guiding the transformation, 3-5000 characters. */
  prompt: string;
  /** Source image URLs to remix (1-8). */
  source_image_urls: string[];
  /** URL for completion callback notifications. */
  callback_url?: string;
  /** Default: 1k. */
  output_resolution?: OutputResolution;
  /** Content safety check toggle. */
  enable_safety_checker?: boolean;
  /** 'auto' preserves the source image aspect ratio. */
  aspect_ratio?: RemixAspectRatio;
}

/** Parameters for Flux 2 Max image remix. */
export interface MaxRemixImageParams {
  model: 'flux-2-max-remix-image';
  /** Text description guiding the transformation, 3-5000 characters. */
  prompt: string;
  /** Exactly one publicly reachable HTTP(S) source image URL. */
  source_image_urls: [string];
  /** URL for completion callback notifications. */
  callback_url?: string;
  /** Max supports only 1k output. */
  output_resolution?: '1k';
  /** Max produces exactly one image. */
  output_count?: 1;
  /** A concrete output aspect ratio is required for Max. */
  aspect_ratio: AspectRatio;
}

/** Parameters for Flux 2 image remix. */
export type RemixImageParams = ProFlexRemixImageParams | MaxRemixImageParams;

export type TextToImageParams = GenerationT2IParams;

/** Acknowledged task with its server-assigned ID. */
export interface TaskCreateResponse extends TaskBillingResponse {
  id: string;
}

/** A single generated image with its CDN URL. */
export interface Image {
  url: string;
}

/**
 * Generation result for a Flux 2 task.
 * `images` is populated once `status` reaches `'completed'`.
 */
export interface TextToImageResponse extends TaskResponse {
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

/** Remix response -- same shape as generation. */
export type RemixImageResponse = TextToImageResponse;
export type CompletedRemixImageResponse = CompletedTextToImageResponse;
