# frozen_string_literal: true

module RunApi
  module Flux2
    module Resources
      class RemixImage
        include RunApi::Core::ResourceHelpers

        ENDPOINT = "/api/v1/flux_2/remix_image"

        RESPONSE_CLASS = Types::RemixImageResponse
        COMPLETED_RESPONSE_CLASS = Types::CompletedRemixImageResponse

        def initialize(http)
          @http = http
        end

        def run(**params)
          task = create(**params)
          poll_until_complete { get(task.id) }
        end

        def create(**params)
          params = compact_params(params)
          validate_params!(params)
          request(:post, ENDPOINT, body: params)
        end

        def get(id)
          request(:get, "#{ENDPOINT}/#{id}")
        end

        private

        def validate_params!(params)
          model = param(params, :model)
          raise Core::ValidationError, "model is required" unless model
          unless Types::REMIX_MODELS.include?(model)
            raise Core::ValidationError, "Invalid model: #{model}. Must be one of: #{Types::REMIX_MODELS.join(", ")}"
          end

          prompt = param(params, :prompt)
          raise Core::ValidationError, "prompt is required" unless prompt

          validate_optional!(params, :aspect_ratio, Types::REMIX_ASPECT_RATIOS)
          validate_optional!(params, :output_resolution, Types::OUTPUT_RESOLUTIONS)
          validate_source_image_urls!(params)
        end

        def validate_source_image_urls!(params)
          urls = param(params, :source_image_urls)
          raise Core::ValidationError, "source_image_urls is required" if urls.nil? || (urls.respond_to?(:empty?) && urls.empty?)
        end
      end
    end
  end
end
