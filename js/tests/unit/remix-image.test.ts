import { describe, it, expect, vi, beforeEach } from 'vitest';
import { RemixImage } from '../../src/resources/remix-image';
import type { HttpClient } from '@runapi.ai/core';
import type { RemixImageResponse, TaskCreateResponse } from '../../src/types';

describe('RemixImage', () => {
  const mockHttp: HttpClient = {
    request: vi.fn(),
  };

  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe('create', () => {
    it('should send correct request for pro remix model', async () => {
      const mockResponse: TaskCreateResponse = { id: 'task-789' };
      vi.mocked(mockHttp.request).mockResolvedValueOnce(mockResponse);

      const remixImage = new RemixImage(mockHttp);
      const result = await remixImage.create({
        model: 'flux-2-pro-remix-image',
        prompt: 'Transform into oil painting style',
        source_image_urls: ['https://cdn.runapi.ai/public/samples/photo.jpg'],
      });

      expect(mockHttp.request).toHaveBeenCalledWith(
        'POST',
        '/api/v1/flux_2/remix_image',
        {
          body: {
            model: 'flux-2-pro-remix-image',
            prompt: 'Transform into oil painting style',
            source_image_urls: ['https://cdn.runapi.ai/public/samples/photo.jpg'],
          },
        }
      );
      expect(result).toEqual(mockResponse);
    });

    it('should send correct request for flex remix model and auto aspect ratio', async () => {
      const mockResponse: TaskCreateResponse = { id: 'task-remix' };
      vi.mocked(mockHttp.request).mockResolvedValueOnce(mockResponse);

      const remixImage = new RemixImage(mockHttp);
      await remixImage.create({
        model: 'flux-2-flex-remix-image',
        prompt: 'Enhance the details',
        source_image_urls: ['https://cdn.runapi.ai/public/samples/input.jpg'],
        aspect_ratio: 'auto',
      });

      expect(mockHttp.request).toHaveBeenCalledWith(
        'POST',
        '/api/v1/flux_2/remix_image',
        {
          body: {
            model: 'flux-2-flex-remix-image',
            prompt: 'Enhance the details',
            source_image_urls: ['https://cdn.runapi.ai/public/samples/input.jpg'],
            aspect_ratio: 'auto',
          },
        }
      );
    });

    it('should send the constrained Max remix request', async () => {
      const mockResponse: TaskCreateResponse = { id: 'task-max-remix' };
      vi.mocked(mockHttp.request).mockResolvedValueOnce(mockResponse);

      const remixImage = new RemixImage(mockHttp);
      await remixImage.create({
        model: 'flux-2-max-remix-image',
        prompt: 'Refine the source product image',
        source_image_urls: ['https://cdn.runapi.ai/public/samples/image.jpg'],
        aspect_ratio: '3:4',
        output_resolution: '1k',
        output_count: 1,
      });

      expect(mockHttp.request).toHaveBeenCalledWith(
        'POST',
        '/api/v1/flux_2/remix_image',
        {
          body: {
            model: 'flux-2-max-remix-image',
            prompt: 'Refine the source product image',
            source_image_urls: ['https://cdn.runapi.ai/public/samples/image.jpg'],
            aspect_ratio: '3:4',
            output_resolution: '1k',
            output_count: 1,
          },
        }
      );
    });

    it('should include optional parameters for remix', async () => {
      const mockResponse: TaskCreateResponse = { id: 'task-opt2' };
      vi.mocked(mockHttp.request).mockResolvedValueOnce(mockResponse);

      const remixImage = new RemixImage(mockHttp);
      await remixImage.create({
        model: 'flux-2-pro-remix-image',
        prompt: 'Style transfer',
        source_image_urls: ['https://cdn.runapi.ai/public/samples/photo.jpg'],
        callback_url: 'https://your-domain.com/api/callback',
        output_resolution: '1k',
        enable_safety_checker: false,
        aspect_ratio: '9:16',
      });

      expect(mockHttp.request).toHaveBeenCalledWith(
        'POST',
        '/api/v1/flux_2/remix_image',
        {
          body: {
            model: 'flux-2-pro-remix-image',
            prompt: 'Style transfer',
            source_image_urls: ['https://cdn.runapi.ai/public/samples/photo.jpg'],
            callback_url: 'https://your-domain.com/api/callback',
            output_resolution: '1k',
            enable_safety_checker: false,
            aspect_ratio: '9:16',
          },
        }
      );
    });
  });

  describe('get', () => {
    it('should fetch task status by ID', async () => {
      const mockResponse: RemixImageResponse = {
        id: 'task-123',
        status: 'completed',
        images: [{ url: 'https://cdn.runapi.ai/public/samples/result.png' }],
      };
      vi.mocked(mockHttp.request).mockResolvedValueOnce(mockResponse);

      const remixImage = new RemixImage(mockHttp);
      const result = await remixImage.get('task-123');

      expect(mockHttp.request).toHaveBeenCalledWith(
        'GET',
        '/api/v1/flux_2/remix_image/task-123',
        {}
      );
      expect(result.images?.[0].url).toBe('https://cdn.runapi.ai/public/samples/result.png');
    });
  });
});
