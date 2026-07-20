# frozen_string_literal: true

require "spec_helper"

RSpec.describe RunApi::Flux2::Resources::RemixImage do
  let(:http) { instance_double(RunApi::Core::HttpClient) }
  let(:remix_image) { described_class.new(http) }
  let(:endpoint) { "/api/v1/flux_2/remix_image" }

  describe "#create" do
    it "POSTs with source_image_urls for remix model" do
      params = {model: "flux-2-pro-remix-image", prompt: "make it blue", source_image_urls: ["https://cdn.runapi.ai/public/samples/input.png"]}
      expect(http).to receive(:request).with(:post, endpoint, body: params)
        .and_return("id" => "task-3")

      result = remix_image.create(**params)
      expect(result).to be_a(RunApi::Flux2::Types::RemixImageResponse)
      expect(result.id).to eq("task-3")
    end

    it "accepts auto aspect_ratio for remix model" do
      params = {model: "flux-2-flex-remix-image", prompt: "brighten", source_image_urls: ["https://cdn.runapi.ai/public/samples/input.png"], aspect_ratio: "auto"}
      expect(http).to receive(:request).with(:post, endpoint, body: params)
        .and_return("id" => "task-4")

      result = remix_image.create(**params)
      expect(result).to be_a(RunApi::Flux2::Types::RemixImageResponse)
      expect(result.id).to eq("task-4")
    end

    it "raises ValidationError when source_image_urls is missing" do
      expect { remix_image.create(model: "flux-2-pro-remix-image", prompt: "test") }
        .to raise_error(RunApi::Core::ValidationError, /source_image_urls is required/)
    end

    it "raises ValidationError when source_image_urls is empty" do
      expect { remix_image.create(model: "flux-2-pro-remix-image", prompt: "test", source_image_urls: []) }
        .to raise_error(RunApi::Core::ValidationError, /source_image_urls must contain between 1 and 8 items/)
    end
  end

  describe "#get" do
    it "GETs the correct endpoint" do
      expect(http).to receive(:request).with(:get, "#{endpoint}/task-1")
        .and_return("id" => "task-1", "status" => "completed")

      result = remix_image.get("task-1")
      expect(result).to be_a(RunApi::Flux2::Types::RemixImageResponse)
      expect(result.status).to eq("completed")
    end
  end
end
