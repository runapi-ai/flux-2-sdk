# frozen_string_literal: true

module RunApi
  module Flux2
    module Types
      MODELS = %w[
        flux-2-pro-text-to-image flux-2-pro-image-to-image
        flux-2-flex-text-to-image flux-2-flex-image-to-image
      ].freeze
      I2I_MODELS = %w[flux-2-pro-image-to-image flux-2-flex-image-to-image].freeze

      ASPECT_RATIOS = %w[1:1 4:3 3:4 16:9 9:16 3:2 2:3].freeze
      ASPECT_RATIOS_I2I = %w[1:1 4:3 3:4 16:9 9:16 3:2 2:3 auto].freeze
      RESOLUTIONS = %w[1K 2K].freeze

      class Image < RunApi::Core::BaseModel
        optional :url, String
      end

      class TextToImageResponse < RunApi::Core::TaskResponse
        required :id, String
        optional :status, String, enum: -> { RunApi::Core::TaskResponse::Status::ALL }
        optional :images, [ -> { Image } ]
        optional :error, String
      end

      # Narrowed response returned by `text_to_image.run()` once polling observes
      # `status: "completed"`. `images` is required so consumers never have to
      # null-check it on a successful task.
      class CompletedTextToImageResponse < TextToImageResponse
        required :images, [ -> { Image } ]
      end
    end
  end
end
