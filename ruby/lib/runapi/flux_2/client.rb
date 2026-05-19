# frozen_string_literal: true

module RunApi
  module Flux2
    # Flux 2 text-to-image API client.
    #
    # @example
    #   client = RunApi::Flux2::Client.new(api_key: "your-api-key")
    #   result = client.text_to_image.run(
    #     model: "flux-2-pro-text-to-image", prompt: "A futuristic cityscape"
    #   )
    class Client
      # @return [Resources::TextToImage] Text-to-image operations.
      attr_reader :text_to_image

      def initialize(api_key: nil, **options)
        @api_key = Core::Auth.resolve_api_key(api_key)

        client_options = Core::ClientOptions.new(api_key: @api_key, **options)
        http = client_options.http_client || Core::HttpClient.new(client_options)
        @text_to_image = Resources::TextToImage.new(http)
      end
    end
  end
end
