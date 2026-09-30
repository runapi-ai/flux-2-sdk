# frozen_string_literal: true

require "runapi/core"
require_relative "flux_2/types"
require_relative "flux_2/resources/text_to_image"
require_relative "flux_2/resources/remix_image"
require_relative "flux_2/client"

module RunApi
  module Flux2
    AuthenticationError = RunApi::Core::AuthenticationError
    RateLimitError = RunApi::Core::RateLimitError
    InsufficientCreditsError = RunApi::Core::InsufficientCreditsError
    NotFoundError = RunApi::Core::NotFoundError
    ValidationError = RunApi::Core::ValidationError
    TaskFailedError = RunApi::Core::TaskFailedError
    TaskTimeoutError = RunApi::Core::TaskTimeoutError
  end
end
