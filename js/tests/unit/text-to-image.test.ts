import { describe, it, expect, vi, beforeEach } from 'vitest';
import { TextToImage } from '../../src/resources/text-to-image';
import type { HttpClient } from '@runapi.ai/core';
import type { TextToImageResponse, TaskCreateResponse } from '../../src/types';

describe('TextToImage', () => {
  const mockHttp: HttpClient = {
    request: vi.fn(),
  };

  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe('create', () => {
    it('should send correct request for text-to-image with pro model', async () => {
      const mockResponse: TaskCreateResponse = { id: 'task-123' };
      vi.mocked(mockHttp.request).mockResolvedValueOnce(mockResponse);

      const textToImage = new TextToImage(mockHttp);
      const result = await textToImage.create({
        model: 'flux-2-pro-text-to-image',
        prompt: 'A beautiful landscape',
        aspect_ratio: '16:9',
      });

      expect(mockHttp.request).toHaveBeenCalledWith(
        'POST',
        '/api/v1/flux_2/text_to_image',
        {
          body: {
            model: 'flux-2-pro-text-to-image',
            prompt: 'A beautiful landscape',
            aspect_ratio: '16:9',
          },
        }
      );
      expect(result).toEqual(mockResponse);
    });

    it('should send correct request for text-to-image with flex model', async () => {
      const mockResponse: TaskCreateResponse = { id: 'task-456' };
      vi.mocked(mockHttp.request).mockResolvedValueOnce(mockResponse);

      const textToImage = new TextToImage(mockHttp);
      const result = await textToImage.create({
        model: 'flux-2-flex-text-to-image',
        prompt: 'Abstract art in pastel colors',
        output_resolution: '2k',
      });

      expect(mockHttp.request).toHaveBeenCalledWith(
        'POST',
        '/api/v1/flux_2/text_to_image',
        {
          body: {
            model: 'flux-2-flex-text-to-image',
            prompt: 'Abstract art in pastel colors',
            output_resolution: '2k',
          },
        }
      );
      expect(result).toEqual(mockResponse);
    });

    it('should include optional parameters for text-to-image', async () => {
      const mockResponse: TaskCreateResponse = { id: 'task-opt' };
      vi.mocked(mockHttp.request).mockResolvedValueOnce(mockResponse);

      const textToImage = new TextToImage(mockHttp);
      await textToImage.create({
        model: 'flux-2-pro-text-to-image',
        prompt: 'Test image',
        callback_url: 'https://example.com/callback',
        output_resolution: '2k',
        enable_safety_checker: true,
        aspect_ratio: '3:2',
      });

      expect(mockHttp.request).toHaveBeenCalledWith(
        'POST',
        '/api/v1/flux_2/text_to_image',
        {
          body: {
            model: 'flux-2-pro-text-to-image',
            prompt: 'Test image',
            callback_url: 'https://example.com/callback',
            output_resolution: '2k',
            enable_safety_checker: true,
            aspect_ratio: '3:2',
          },
        }
      );
    });

  });

  describe('get', () => {
    it('should fetch task status by ID', async () => {
      const mockResponse: TextToImageResponse = {
        id: 'task-123',
        status: 'processing',
      };
      vi.mocked(mockHttp.request).mockResolvedValueOnce(mockResponse);

      const textToImage = new TextToImage(mockHttp);
      const result = await textToImage.get('task-123');

      expect(mockHttp.request).toHaveBeenCalledWith(
        'GET',
        '/api/v1/flux_2/text_to_image/task-123',
        {}
      );
      expect(result).toEqual(mockResponse);
    });

    it('should return completed status with images', async () => {
      const mockResponse: TextToImageResponse = {
        id: 'task-123',
        status: 'completed',
        images: [
          { url: 'https://cdn.runapi.ai/public/samples/result.png' },
        ],
      };
      vi.mocked(mockHttp.request).mockResolvedValueOnce(mockResponse);

      const textToImage = new TextToImage(mockHttp);
      const result = await textToImage.get('task-123');

      expect(result.status).toBe('completed');
      expect(result.images).toHaveLength(1);
      expect(result.images?.[0].url).toBe('https://cdn.runapi.ai/public/samples/result.png');
    });

    it('should return failed status with error', async () => {
      const mockResponse: TextToImageResponse = {
        id: 'task-123',
        status: 'failed',
        error: 'Content policy violation',
      };
      vi.mocked(mockHttp.request).mockResolvedValueOnce(mockResponse);

      const textToImage = new TextToImage(mockHttp);
      const result = await textToImage.get('task-123');

      expect(result.status).toBe('failed');
      expect(result.error).toBe('Content policy violation');
    });
  });

  describe('run', () => {
    it('should create and poll until completion', async () => {
      const createResponse: TaskCreateResponse = { id: 'task-123' };
      const processingResponse: TextToImageResponse = {
        id: 'task-123',
        status: 'processing',
      };
      const completedResponse: TextToImageResponse = {
        id: 'task-123',
        status: 'completed',
        images: [
          { url: 'https://cdn.runapi.ai/public/samples/result.png' },
        ],
      };

      vi.mocked(mockHttp.request)
        .mockResolvedValueOnce(createResponse)
        .mockResolvedValueOnce(processingResponse)
        .mockResolvedValueOnce(completedResponse);

      const textToImage = new TextToImage(mockHttp);
      const result = await textToImage.run({
        model: 'flux-2-pro-text-to-image',
        prompt: 'Test image',
      });

      expect(result.status).toBe('completed');
      expect(result.images).toHaveLength(1);
    });
  });
});
