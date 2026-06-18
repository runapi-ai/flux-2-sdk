# frozen_string_literal: true

module RunApi
  module Flux2
    # Type definitions and constants for Flux 2.
    # Each operation has pro (higher fidelity) and flex (faster, lower cost) tiers.
    module Types
      MODELS = %w[
        flux-2-pro-text-to-image flux-2-pro-remix-image
        flux-2-flex-text-to-image flux-2-flex-remix-image
      ].freeze
      TEXT_TO_IMAGE_MODELS = %w[flux-2-pro-text-to-image flux-2-flex-text-to-image].freeze
      REMIX_MODELS = %w[flux-2-pro-remix-image flux-2-flex-remix-image].freeze

      ASPECT_RATIOS = %w[1:1 4:3 3:4 16:9 9:16 3:2 2:3].freeze
      # Remix adds 'auto' to preserve the source image aspect ratio.
      REMIX_ASPECT_RATIOS = %w[1:1 4:3 3:4 16:9 9:16 3:2 2:3 auto].freeze
      OUTPUT_RESOLUTIONS = %w[1k 2k].freeze

      # A single generated image with its CDN URL.
      class Image < RunApi::Core::BaseModel
        optional :url, String
      end

      # Generation result. +images+ is populated once +status+ is +"completed"+.
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

      # Remix response -- same shape as generation.
      class RemixImageResponse < TextToImageResponse
      end

      # Narrowed remix response from +run()+ where +images+ is guaranteed present.
      class CompletedRemixImageResponse < CompletedTextToImageResponse
      end
    end
  end
end
