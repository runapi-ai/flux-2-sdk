# frozen_string_literal: true

module RunApi
  module Flux2
    module Resources
      # Flux 2 text-to-image resource.
      # Generate images from text or image prompts with Flux 2 models.
      class TextToImage
        include RunApi::Core::ResourceHelpers

        ENDPOINT = "/api/v1/flux_2/text_to_image"

        RESPONSE_CLASS = Types::TextToImageResponse
        COMPLETED_RESPONSE_CLASS = Types::CompletedTextToImageResponse

        def initialize(http)
          @http = http
        end

        # Generate an image and wait until complete.
        #
        # @param params [Hash] text-to-image parameters
        # @return [RunApi::Flux2::Types::CompletedTextToImageResponse] completed text-to-image result
        def run(**params)
          task = create(**params)
          poll_until_complete { get(task.id) }
        end

        # Create a text-to-image task.
        #
        # @param params [Hash] text-to-image parameters
        # @return [RunApi::Flux2::Types::TextToImageResponse] task creation result with id
        def create(**params)
          params = compact_params(params)
          validate_params!(params)
          request(:post, ENDPOINT, body: params)
        end

        # Get text-to-image status by task ID.
        #
        # @param id [String] task ID
        # @return [RunApi::Flux2::Types::TextToImageResponse] current text-to-image status
        def get(id)
          request(:get, "#{ENDPOINT}/#{id}")
        end

        private

        def validate_params!(params)
          raise Core::ValidationError, "model is required" unless param(params, :model)
          raise Core::ValidationError, "prompt is required" unless param(params, :prompt)

          model = param(params, :model)
          unless Types::TEXT_TO_IMAGE_MODELS.include?(model)
            raise Core::ValidationError, "Invalid model: #{model}. Must be one of: #{Types::TEXT_TO_IMAGE_MODELS.join(", ")}"
          end

          validate_optional!(params, :aspect_ratio, Types::ASPECT_RATIOS)
          validate_optional!(params, :output_resolution, Types::OUTPUT_RESOLUTIONS)
        end
      end
    end
  end
end
