# frozen_string_literal: true

module RunApi
  module Flux2
    # Flux 2 text-to-image and remix API client.
    #
    # Pro and flex tiers for both text-to-image generation and
    # text-guided image remixing.
    #
    # @example
    #   client = RunApi::Flux2::Client.new(api_key: "your-api-key")
    #   result = client.text_to_image.run(
    #     model: "flux-2-pro-text-to-image", prompt: "A futuristic cityscape"
    #   )
    class Client < RunApi::Core::Client
      # @return [Resources::TextToImage] Text-to-image generation operations.
      attr_reader :text_to_image
      # @return [Resources::RemixImage] Image remix operations with text-guided transformations.
      attr_reader :remix_image

      def initialize(api_key: nil, **options)
        super
        @text_to_image = Resources::TextToImage.new(http)
        @remix_image = Resources::RemixImage.new(http)
      end
    end
  end
end
