package flux2

import "github.com/runapi-ai/core-sdk/go/core"

// TaskStatus represents the lifecycle state of an async task (e.g. "pending", "processing", "completed", "failed").
type TaskStatus string

// TextToImageParams holds the request parameters for generating an image from a text prompt.
// Flux 2 Max requires a concrete AspectRatio, supports only 1k output, and produces one image.
type TextToImageParams struct {
	Model               string `json:"model" help:"required; model slug"`
	Prompt              string `json:"prompt" help:"required; 3-5000 chars"`
	AspectRatio         string `json:"aspect_ratio,omitempty" help:"optional except Flux 2 Max; output aspect ratio; Default: 1:1"`
	OutputResolution    string `json:"output_resolution,omitempty" help:"optional; output resolution; Flux 2 Max supports only 1k; Default: 1k"`
	OutputCount         int    `json:"output_count,omitempty" help:"optional; Flux 2 Max supports only 1"`
	EnableSafetyChecker *bool  `json:"enable_safety_checker,omitempty" help:"optional except Flux 2 Max; content safety check toggle"`
	CallbackURL         string `json:"callback_url,omitempty" help:"optional; webhook URL"`
}

// RemixImageParams holds the request parameters for creating prompt-guided variations
// from 1-8 source images. Flux 2 Max requires exactly one HTTP(S) source image and a concrete aspect ratio.
type RemixImageParams struct {
	Model               string   `json:"model" help:"required; model slug"`
	Prompt              string   `json:"prompt" help:"required; 3-5000 chars"`
	SourceImageURLs     []string `json:"source_image_urls" help:"required; 1-8 source image URLs"`
	AspectRatio         string   `json:"aspect_ratio,omitempty" help:"optional except Flux 2 Max; output aspect ratio; auto preserves the source image ratio"`
	OutputResolution    string   `json:"output_resolution,omitempty" help:"optional; output resolution; Flux 2 Max supports only 1k; Default: 1k"`
	OutputCount         int      `json:"output_count,omitempty" help:"optional; Flux 2 Max supports only 1"`
	EnableSafetyChecker *bool    `json:"enable_safety_checker,omitempty" help:"optional except Flux 2 Max; content safety check toggle"`
	CallbackURL         string   `json:"callback_url,omitempty" help:"optional; webhook URL"`
}

// AsyncTaskResponse is the base response for an asynchronous generation task.
// It implements core.TaskResponse so it can be used with the polling helpers.
type AsyncTaskResponse struct {
	core.TaskBillingFacts
	ID     string     `json:"id"`
	Status TaskStatus `json:"status"`
	Error  string     `json:"error,omitempty"`
}

// GetID returns the unique task identifier assigned by the API.
func (r AsyncTaskResponse) GetID() string { return r.ID }

// GetStatus returns the current lifecycle state as a plain string.
func (r AsyncTaskResponse) GetStatus() string { return string(r.Status) }

// GetError returns the error message if the task failed, or an empty string otherwise.
func (r AsyncTaskResponse) GetError() string { return r.Error }

// Image holds a CDN URL pointing to a generated image.
type Image struct {
	URL string `json:"url"`
}

// TextToImageResponse is the result of a text-to-image generation task,
// embedding the async task metadata alongside the produced images.
type TextToImageResponse struct {
	AsyncTaskResponse
	Images []Image `json:"images,omitempty"`
}

// RemixImageResponse is an alias for TextToImageResponse because remix returns the same shape.
type RemixImageResponse = TextToImageResponse
