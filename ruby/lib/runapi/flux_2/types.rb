# frozen_string_literal: true

module RunApi
  module Flux2
    # Type definitions for Flux 2.
    # Each operation has pro (higher fidelity) and flex (faster, lower cost) tiers.
    module Types
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
