import { describe, it, expect, beforeEach, afterAll } from 'vitest';
import { AuthenticationError } from '@runapi.ai/core';
import { Flux2Client } from '../../src';

const originalEnv = process.env.RUNAPI_API_KEY;

describe('Flux2Client', () => {
  beforeEach(() => {
    delete process.env.RUNAPI_API_KEY;
  });

  afterAll(() => {
    if (originalEnv === undefined) {
      delete process.env.RUNAPI_API_KEY;
    } else {
      process.env.RUNAPI_API_KEY = originalEnv;
    }
  });

  it('initializes with an API key', () => {
    const client = new Flux2Client({ apiKey: 'test-key' });
    expect(client.textToImage).toBeDefined();
  });

  it('throws when apiKey missing and env unset', () => {
    expect(() => new Flux2Client()).toThrow(AuthenticationError);
    expect(() => new Flux2Client({ apiKey: '' })).toThrow(AuthenticationError);
  });

  it('reads apiKey from RUNAPI_API_KEY env var', () => {
    process.env.RUNAPI_API_KEY = 'env-key';
    const client = new Flux2Client();
    expect(client.textToImage).toBeDefined();
  });

  it('exposes textToImage resource', () => {
    const client = new Flux2Client({ apiKey: 'test-key' });
    expect(client.textToImage).toBeDefined();
    expect(typeof client.textToImage.run).toBe('function');
    expect(typeof client.textToImage.create).toBe('function');
    expect(typeof client.textToImage.get).toBe('function');
  });
});
