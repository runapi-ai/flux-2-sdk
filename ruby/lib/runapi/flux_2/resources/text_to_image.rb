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
          unless Types::MODELS.include?(model)
            raise Core::ValidationError, "Invalid model: #{model}. Must be one of: #{Types::MODELS.join(", ")}"
          end

          validate_aspect_ratio!(params, model)
          validate_optional!(params, :resolution, Types::RESOLUTIONS)
          validate_input_urls!(params, model)
        end

        def validate_aspect_ratio!(params, model)
          return unless param(params, :aspect_ratio)

          allowed = Types::I2I_MODELS.include?(model) ? Types::ASPECT_RATIOS_I2I : Types::ASPECT_RATIOS
          value = param(params, :aspect_ratio)
          unless allowed.include?(value)
            raise Core::ValidationError, "Invalid aspect_ratio: #{value}. Must be one of: #{allowed.join(", ")}"
          end
        end

        def validate_input_urls!(params, model)
          return unless Types::I2I_MODELS.include?(model)

          urls = param(params, :input_urls)
          raise Core::ValidationError, "input_urls is required for image-to-image models" if urls.nil? || (urls.respond_to?(:empty?) && urls.empty?)
        end
      end
    end
  end
end
