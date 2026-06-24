import type { HttpClient, RequestOptions, PollingOptions, ActionSchema } from '@runapi.ai/core';
import { compactParams, validateParams } from '@runapi.ai/core';
import { pollUntilComplete } from '@runapi.ai/core/internal';
import { contract } from '../contract_gen';
import type {
  CompletedRemixImageResponse,
  RemixImageParams,
  RemixImageResponse,
  TaskCreateResponse,
} from '../types';

const ENDPOINT = '/api/v1/flux_2/remix_image';

/** Flux 2 image remix: transform source images with text-guided prompts. */
export class RemixImage {
  constructor(private readonly http: HttpClient) {}

  /**
   * Remix an image and wait until complete.
   * @param params Image remix parameters.
   * @param options Per-request and polling overrides.
   * @returns The completed remix result with images.
   */
  async run(params: RemixImageParams, options?: RequestOptions & PollingOptions): Promise<CompletedRemixImageResponse> {
    const { id } = await this.create(params, options);
    const response = await pollUntilComplete<RemixImageResponse>(() => this.get(id, options), {
      maxWaitMs: options?.maxWaitMs,
      pollIntervalMs: options?.pollIntervalMs,
    });
    return response as CompletedRemixImageResponse;
  }

  /**
   * Create an image remix task; returns immediately with a task id.
   * @param params Image remix parameters.
   * @param options Per-request overrides.
   * @returns The task creation result with id.
   */
  async create(params: RemixImageParams, options?: RequestOptions): Promise<TaskCreateResponse> {
    const body = compactParams(params);
    validateParams(contract['remix-image'] as ActionSchema, body as Record<string, unknown>);
    return this.http.request<TaskCreateResponse>('POST', ENDPOINT, {
      body,
      ...options,
    });
  }

  /**
   * Fetch the current status of an image remix task.
   * @param id The task id.
   * @param options Per-request overrides.
   * @returns The current remix status.
   */
  async get(id: string, options?: RequestOptions): Promise<RemixImageResponse> {
    return this.http.request<RemixImageResponse>('GET', `${ENDPOINT}/${id}`, {
      ...options,
    });
  }
}
