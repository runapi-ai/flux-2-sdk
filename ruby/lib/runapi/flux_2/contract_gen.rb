# frozen_string_literal: true

module RunApi
  module Flux2
    CONTRACT = {
      "remix-image" => {
        "models" => ["flux-2-flex-remix-image", "flux-2-pro-remix-image"],
        "fields_by_model" => {
          "flux-2-flex-remix-image" => {
            "aspect_ratio" => {
              "enum" => ["1:1", "4:3", "3:4", "16:9", "9:16", "3:2", "2:3", "auto"]
            },
            "output_resolution" => {
              "enum" => ["1k", "2k"]
            },
            "prompt" => {
              "required" => true
            },
            "source_image_urls" => {
              "required" => true
            }
          },
          "flux-2-pro-remix-image" => {
            "aspect_ratio" => {
              "enum" => ["1:1", "4:3", "3:4", "16:9", "9:16", "3:2", "2:3", "auto"]
            },
            "output_resolution" => {
              "enum" => ["1k", "2k"]
            },
            "prompt" => {
              "required" => true
            },
            "source_image_urls" => {
              "required" => true
            }
          }
        }
      },
      "text-to-image" => {
        "models" => ["flux-2-flex-text-to-image", "flux-2-pro-text-to-image"],
        "fields_by_model" => {
          "flux-2-flex-text-to-image" => {
            "aspect_ratio" => {
              "enum" => ["1:1", "4:3", "3:4", "16:9", "9:16", "3:2", "2:3"]
            },
            "output_resolution" => {
              "enum" => ["1k", "2k"]
            },
            "prompt" => {
              "required" => true
            }
          },
          "flux-2-pro-text-to-image" => {
            "aspect_ratio" => {
              "enum" => ["1:1", "4:3", "3:4", "16:9", "9:16", "3:2", "2:3"]
            },
            "output_resolution" => {
              "enum" => ["1k", "2k"]
            },
            "prompt" => {
              "required" => true
            }
          }
        }
      }
    }.freeze
  end
end
