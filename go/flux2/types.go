package flux2

type TaskStatus string

type TextToImageParams struct {
	Model       string   `json:"model" help:"required; flux-2-pro-text-to-image, flux-2-pro-image-to-image, flux-2-flex-text-to-image, or flux-2-flex-image-to-image"`
	Prompt      string   `json:"prompt" help:"required; 3-5000 chars"`
	AspectRatio string   `json:"aspect_ratio,omitempty" help:"optional; 1:1, 4:3, 3:4, 16:9, 9:16, 3:2, 2:3, or auto (I2I only). Default: 1:1"`
	Resolution  string   `json:"resolution,omitempty" help:"optional; 1K or 2K. Default: 1K"`
	InputURLs   []string `json:"input_urls,omitempty" help:"required for I2I; 1-8 image URLs"`
	NsfwChecker *bool    `json:"nsfw_checker,omitempty" help:"optional; content filtering. Default: false"`
	CallbackURL string   `json:"callback_url,omitempty" help:"optional; webhook URL"`
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
