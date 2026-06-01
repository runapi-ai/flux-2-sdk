package flux2

type TaskStatus string

type TextToImageParams struct {
	Model               string   `json:"model" help:"required; model slug"`
	Prompt              string   `json:"prompt" help:"required; 3-5000 chars"`
	AspectRatio         string   `json:"aspect_ratio,omitempty" help:"optional; output aspect ratio; Default: 1:1"`
	OutputResolution    string   `json:"output_resolution,omitempty" help:"optional; output resolution; Default: 1k"`
	EnableSafetyChecker *bool    `json:"enable_safety_checker,omitempty" help:"optional; content safety check toggle"`
	CallbackURL         string   `json:"callback_url,omitempty" help:"optional; webhook URL"`
}

type RemixImageParams struct {
	Model               string   `json:"model" help:"required; model slug"`
	Prompt              string   `json:"prompt" help:"required; 3-5000 chars"`
	SourceImageURLs     []string `json:"source_image_urls" help:"required; 1-8 source image URLs"`
	AspectRatio         string   `json:"aspect_ratio,omitempty" help:"optional; output aspect ratio; auto preserves source image ratio"`
	OutputResolution    string   `json:"output_resolution,omitempty" help:"optional; output resolution; Default: 1k"`
	EnableSafetyChecker *bool    `json:"enable_safety_checker,omitempty" help:"optional; content safety check toggle"`
	CallbackURL         string   `json:"callback_url,omitempty" help:"optional; webhook URL"`
}

type AsyncTaskResponse struct {
	ID     string     `json:"id"`
	Status TaskStatus `json:"status"`
	Error  string     `json:"error,omitempty"`
}

func (r AsyncTaskResponse) GetID() string     { return r.ID }
func (r AsyncTaskResponse) GetStatus() string { return string(r.Status) }
func (r AsyncTaskResponse) GetError() string  { return r.Error }

type Image struct {
	URL string `json:"url"`
}

type TextToImageResponse struct {
	AsyncTaskResponse
	Images []Image `json:"images,omitempty"`
}

type RemixImageResponse = TextToImageResponse
