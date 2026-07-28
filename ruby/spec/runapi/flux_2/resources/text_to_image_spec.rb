# frozen_string_literal: true

require "spec_helper"

RSpec.describe RunApi::Flux2::Resources::TextToImage do
  let(:http) { instance_double(RunApi::Core::HttpClient) }
  let(:text_to_image) { described_class.new(http) }
  let(:endpoint) { "/api/v1/flux_2/text_to_image" }

  describe "#create" do
    context "text-to-image" do
      it "POSTs to the correct endpoint with params" do
        params = {model: "flux-2-pro-text-to-image", prompt: "a futuristic cityscape"}
        expect(http).to receive(:request).with(:post, endpoint, body: params)
          .and_return("id" => "task-1")

        result = text_to_image.create(**params)
        expect(result).to be_a(RunApi::Flux2::Types::TextToImageResponse)
        expect(result.id).to eq("task-1")
        expect(result["id"]).to eq("task-1")
      end

      it "accepts flux-2-flex-text-to-image model" do
        params = {model: "flux-2-flex-text-to-image", prompt: "a dog", aspect_ratio: "16:9", enable_safety_checker: true}
        expect(http).to receive(:request).with(:post, endpoint, body: params)
          .and_return("id" => "task-2")

        result = text_to_image.create(**params)
        expect(result).to be_a(RunApi::Flux2::Types::TextToImageResponse)
        expect(result.id).to eq("task-2")
        expect(result["id"]).to eq("task-2")
      end

      it "accepts Flux 2 Max with its constrained request fields" do
        params = {
          model: "flux-2-max-text-to-image", prompt: "a detailed product image", aspect_ratio: "4:3",
          output_resolution: "1k", output_count: 1
        }
        expect(http).to receive(:request).with(:post, endpoint, body: params)
          .and_return("id" => "task-max")

        result = text_to_image.create(**params)
        expect(result.id).to eq("task-max")
      end

      it "requires aspect_ratio for Flux 2 Max" do
        expect { text_to_image.create(model: "flux-2-max-text-to-image", prompt: "a detailed product image") }
          .to raise_error(RunApi::Core::ValidationError, /aspect_ratio is required/)
      end

      it "raises ValidationError for invalid aspect_ratio on T2I model" do
        expect { text_to_image.create(model: "flux-2-pro-text-to-image", prompt: "test", aspect_ratio: "auto") }
          .to raise_error(RunApi::Core::ValidationError, /aspect_ratio must be one of/)
      end
    end

    it "raises ValidationError when model is missing" do
      expect { text_to_image.create(prompt: "test") }
        .to raise_error(RunApi::Core::ValidationError, /model must be one of/)
    end

    it "raises ValidationError when prompt is missing" do
      expect { text_to_image.create(model: "flux-2-pro-text-to-image") }
        .to raise_error(RunApi::Core::ValidationError, /prompt is required/)
    end

    it "raises ValidationError for invalid model" do
      expect { text_to_image.create(model: "invalid", prompt: "test") }
        .to raise_error(RunApi::Core::ValidationError, /model must be one of/)
    end

    it "raises ValidationError for invalid output_resolution" do
      expect { text_to_image.create(model: "flux-2-pro-text-to-image", prompt: "test", output_resolution: "4k") }
        .to raise_error(RunApi::Core::ValidationError, /output_resolution must be one of/)
    end

    it "raises ValidationError for remix model on text-to-image resource" do
      expect { text_to_image.create(model: "flux-2-pro-remix-image", prompt: "test", source_image_urls: ["https://cdn.runapi.ai/public/samples/input.png"]) }
        .to raise_error(RunApi::Core::ValidationError, /model must be one of/)
    end

    it "passes valid optional params without error" do
      params = {model: "flux-2-pro-text-to-image", prompt: "test", aspect_ratio: "3:2", output_resolution: "2k", enable_safety_checker: false}
      expect(http).to receive(:request).with(:post, endpoint, body: params).and_return("id" => "t1")

      text_to_image.create(**params)
    end
  end

  describe "#get" do
    it "GETs the correct endpoint" do
      expect(http).to receive(:request).with(:get, "#{endpoint}/task-1")
        .and_return("id" => "task-1", "status" => "completed")

      result = text_to_image.get("task-1")
      expect(result).to be_a(RunApi::Flux2::Types::TextToImageResponse)
      expect(result.status).to eq("completed")
      expect(result["status"]).to eq("completed")
    end
  end

  describe "#run" do
    it "creates then polls until complete" do
      expect(http).to receive(:request).with(:post, endpoint, body: {model: "flux-2-pro-text-to-image", prompt: "cat"})
        .and_return("id" => "task-1")

      expect(http).to receive(:request).with(:get, "#{endpoint}/task-1")
        .and_return("id" => "task-1", "status" => "processing")
      expect(http).to receive(:request).with(:get, "#{endpoint}/task-1")
        .and_return("id" => "task-1", "status" => "completed", "images" => [{"url" => "https://cdn.runapi.ai/public/samples/input.png"}])

      allow(RunApi::Core::Polling).to receive(:sleep)

      result = text_to_image.run(model: "flux-2-pro-text-to-image", prompt: "cat")
      expect(result.images.first.url).to eq("https://cdn.runapi.ai/public/samples/input.png")
      expect(result["images"].first["url"]).to eq("https://cdn.runapi.ai/public/samples/input.png")
    end
  end
end
