// Package flux2 provides the Flux 2 image generation API client.
//
//	client, err := flux_2.NewClient(option.WithAPIKey("sk-your-api-key"))
//	result, err := client.TextToImage.Run(ctx, flux_2.TextToImageParams{
//	    Model: "flux-2-pro-text-to-image", Prompt: "A beautiful landscape",
//	})
package flux2

import (
	"context"

	"github.com/runapi-ai/core-sdk/go/base"
	"github.com/runapi-ai/core-sdk/go/core"
	"github.com/runapi-ai/core-sdk/go/option"
)

const (
	textToImagePath = "/api/v1/flux_2/text_to_image"
	remixImagePath  = "/api/v1/flux_2/remix_image"
)

// Client is the Flux 2 image generation API client.
type Client struct {
	base.Base
	// TextToImage provides text-to-image operations.
	TextToImage *TextToImage
	// RemixImage provides source-image remix operations.
	RemixImage *RemixImage
}

// NewClient creates a Flux 2 client with the given options.
func NewClient(opts ...option.ClientOption) (*Client, error) {
	resolved, err := option.ResolveClientOptions(opts...)
	if err != nil {
		return nil, err
	}
	httpClient, err := core.NewHTTPClient(resolved)
	if err != nil {
		return nil, err
	}
	return NewClientWithHTTP(httpClient), nil
}

// NewClientWithHTTP creates a Flux 2 client with a pre-configured HTTP transport.
func NewClientWithHTTP(httpClient core.HTTPClient) *Client {
	return &Client{
		Base:        base.New(httpClient),
		TextToImage: &TextToImage{http: httpClient},
		RemixImage:  &RemixImage{http: httpClient},
	}
}

// TextToImage creates text-to-image tasks using Flux 2 models.
type TextToImage struct{ http core.HTTPClient }

// Create submits a Flux 2 text-to-image task and returns immediately with a task id.
func (r *TextToImage) Create(ctx context.Context, params TextToImageParams, opts ...option.RequestOption) (*core.TaskCreateResponse, error) {
	requestOptions, _ := option.ResolveRequestOptions(opts...)
	body := core.CompactParams(params)
	if err := core.ValidateParams(contractSchema["text-to-image"], body); err != nil {
		return nil, err
	}
	return core.PostJSON[core.TaskCreateResponse](ctx, r.http, textToImagePath, body, requestOptions)
}

// Get fetches the current status of a Flux 2 text-to-image task by id.
func (r *TextToImage) Get(ctx context.Context, id string, opts ...option.RequestOption) (*TextToImageResponse, error) {
	requestOptions, _ := option.ResolveRequestOptions(opts...)
	return core.GetJSON[TextToImageResponse](ctx, r.http, core.ResourcePath(textToImagePath, id), requestOptions)
}

// Run submits a Flux 2 text-to-image task and polls until it completes.
func (r *TextToImage) Run(ctx context.Context, params TextToImageParams, opts ...option.RequestOption) (*TextToImageResponse, error) {
	_, pollingOptions := option.ResolveRequestOptions(opts...)
	return core.RunAsync(ctx, func(ctx context.Context) (*core.TaskCreateResponse, error) { return r.Create(ctx, params, opts...) }, func(ctx context.Context, id string) (*TextToImageResponse, error) { return r.Get(ctx, id, opts...) }, pollingOptions)
}

// RemixImage creates prompt-guided variations from source images.
type RemixImage struct{ http core.HTTPClient }

// Create submits a Flux 2 image remix task and returns immediately with a task id.
func (r *RemixImage) Create(ctx context.Context, params RemixImageParams, opts ...option.RequestOption) (*core.TaskCreateResponse, error) {
	requestOptions, _ := option.ResolveRequestOptions(opts...)
	body := core.CompactParams(params)
	if err := core.ValidateParams(contractSchema["remix-image"], body); err != nil {
		return nil, err
	}
	return core.PostJSON[core.TaskCreateResponse](ctx, r.http, remixImagePath, body, requestOptions)
}

// Get fetches the current status of a Flux 2 image remix task by id.
func (r *RemixImage) Get(ctx context.Context, id string, opts ...option.RequestOption) (*RemixImageResponse, error) {
	requestOptions, _ := option.ResolveRequestOptions(opts...)
	return core.GetJSON[RemixImageResponse](ctx, r.http, core.ResourcePath(remixImagePath, id), requestOptions)
}

// Run submits a Flux 2 image remix task and polls until it completes.
func (r *RemixImage) Run(ctx context.Context, params RemixImageParams, opts ...option.RequestOption) (*RemixImageResponse, error) {
	_, pollingOptions := option.ResolveRequestOptions(opts...)
	return core.RunAsync(ctx, func(ctx context.Context) (*core.TaskCreateResponse, error) { return r.Create(ctx, params, opts...) }, func(ctx context.Context, id string) (*RemixImageResponse, error) { return r.Get(ctx, id, opts...) }, pollingOptions)
}
