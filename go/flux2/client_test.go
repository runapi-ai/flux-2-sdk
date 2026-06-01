package flux2

import (
	"context"
	"encoding/json"
	"testing"

	"github.com/runapi-ai/core-sdk/go/core"
)

type stubHTTPClient struct {
	method   string
	path     string
	body     any
	response json.RawMessage
}

func (s *stubHTTPClient) Request(_ context.Context, method, path string, opts *core.HTTPRequestOptions) (json.RawMessage, error) {
	s.method = method
	s.path = path
	if opts != nil {
		s.body = opts.Body
	}
	return s.response, nil
}

func TestTextToImageCreate(t *testing.T) {
	stub := &stubHTTPClient{
		response: json.RawMessage(`{"id":"task_123","status":"processing"}`),
	}
	client := NewClientWithHTTP(stub)
	enableSafetyChecker := true
	resp, err := client.TextToImage.Create(context.Background(), TextToImageParams{
		Prompt:              "a beautiful landscape",
		Model:               "flux-2-pro-text-to-image",
		OutputResolution:    "2k",
		EnableSafetyChecker: &enableSafetyChecker,
	})
	if err != nil {
		t.Fatal(err)
	}
	if stub.method != "POST" || stub.path != "/api/v1/flux_2/text_to_image" {
		t.Fatalf("unexpected request: %s %s", stub.method, stub.path)
	}
	body := stub.body.(map[string]any)
	if body["prompt"] != "a beautiful landscape" {
		t.Fatalf("unexpected prompt: %v", body["prompt"])
	}
	if body["model"] != "flux-2-pro-text-to-image" {
		t.Fatalf("unexpected model: %v", body["model"])
	}
	if body["output_resolution"] != "2k" {
		t.Fatalf("unexpected output_resolution: %v", body["output_resolution"])
	}
	if _, ok := body["resolution"]; ok {
		t.Fatalf("unexpected provider resolution key: %v", body["resolution"])
	}
	if body["enable_safety_checker"] != true {
		t.Fatalf("unexpected enable_safety_checker: %v", body["enable_safety_checker"])
	}
	if resp.ID != "task_123" {
		t.Fatalf("unexpected task ID: %v", resp.ID)
	}
}

func TestTextToImageGet(t *testing.T) {
	stub := &stubHTTPClient{
		response: json.RawMessage(`{"id":"task_456","status":"completed","images":[{"url":"https://cdn.runapi.ai/public/samples/result.jpg"}]}`),
	}
	client := NewClientWithHTTP(stub)
	resp, err := client.TextToImage.Get(context.Background(), "task_abc")
	if err != nil {
		t.Fatal(err)
	}
	if stub.method != "GET" || stub.path != "/api/v1/flux_2/text_to_image/task_abc" {
		t.Fatalf("unexpected request: %s %s", stub.method, stub.path)
	}
	if resp.ID != "task_456" {
		t.Fatalf("unexpected ID: %v", resp.ID)
	}
	if string(resp.Status) != "completed" {
		t.Fatalf("unexpected status: %v", resp.Status)
	}
	if len(resp.Images) != 1 || resp.Images[0].URL != "https://cdn.runapi.ai/public/samples/result.jpg" {
		t.Fatalf("unexpected images: %v", resp.Images)
	}
}

func TestRemixImageCreate(t *testing.T) {
	stub := &stubHTTPClient{
		response: json.RawMessage(`{"id":"task_789","status":"processing"}`),
	}
	client := NewClientWithHTTP(stub)
	resp, err := client.RemixImage.Create(context.Background(), RemixImageParams{
		Prompt:          "make it cinematic",
		Model:           "flux-2-pro-remix-image",
		SourceImageURLs: []string{"https://cdn.runapi.ai/public/samples/source.jpg"},
		AspectRatio:     "auto",
	})
	if err != nil {
		t.Fatal(err)
	}
	if stub.method != "POST" || stub.path != "/api/v1/flux_2/remix_image" {
		t.Fatalf("unexpected request: %s %s", stub.method, stub.path)
	}
	body := stub.body.(map[string]any)
	if body["model"] != "flux-2-pro-remix-image" {
		t.Fatalf("unexpected model: %v", body["model"])
	}
	if _, ok := body["input_urls"]; ok {
		t.Fatalf("unexpected provider input_urls key: %v", body["input_urls"])
	}
	sourceURLs, ok := body["source_image_urls"].([]any)
	if !ok || len(sourceURLs) != 1 || sourceURLs[0] != "https://cdn.runapi.ai/public/samples/source.jpg" {
		t.Fatalf("unexpected source_image_urls: %#v", body["source_image_urls"])
	}
	if resp.ID != "task_789" {
		t.Fatalf("unexpected task ID: %v", resp.ID)
	}
}
