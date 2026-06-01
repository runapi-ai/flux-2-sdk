# frozen_string_literal: true

module RunApi
  module Flux2
    module Types
      MODELS = %w[
        flux-2-pro-text-to-image flux-2-pro-remix-image
        flux-2-flex-text-to-image flux-2-flex-remix-image
      ].freeze
      TEXT_TO_IMAGE_MODELS = %w[flux-2-pro-text-to-image flux-2-flex-text-to-image].freeze
      REMIX_MODELS = %w[flux-2-pro-remix-image flux-2-flex-remix-image].freeze

      ASPECT_RATIOS = %w[1:1 4:3 3:4 16:9 9:16 3:2 2:3].freeze
      REMIX_ASPECT_RATIOS = %w[1:1 4:3 3:4 16:9 9:16 3:2 2:3 auto].freeze
      OUTPUT_RESOLUTIONS = %w[1k 2k].freeze

      class Image < RunApi::Core::BaseModel
        optional :url, String
      end

      class TextToImageResponse < RunApi::Core::TaskResponse
        required :id, String
        optional :status, String, enum: -> { RunApi::Core::TaskResponse::Status::ALL }
        optional :images, [-> { Image }]
        optional :error, String
      end

      # Narrowed response returned by `text_to_image.run()` once polling observes
      # `status: "completed"`. `images` is required so consumers never have to
      # null-check it on a successful task.
      class CompletedTextToImageResponse < TextToImageResponse
        required :images, [-> { Image }]
      end

      class RemixImageResponse < TextToImageResponse
      end

      class CompletedRemixImageResponse < CompletedTextToImageResponse
      end
    end
  end
end
