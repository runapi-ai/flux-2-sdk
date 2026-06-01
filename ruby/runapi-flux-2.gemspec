# frozen_string_literal: true

Dir.chdir(__dir__) do

  Gem::Specification.new do |spec|
    spec.name = "runapi-flux-2"
    spec.version = "0.2.5"
    spec.authors = ["RunAPI"]
    spec.email = ["contact@runapi.ai"]

    spec.summary = "Flux API Ruby SDK for RunAPI"
    spec.description = "The flux api Ruby SDK is the language-specific package for Flux 2 on RunAPI. Use this flux api package for text-to-image, remix-image, and creative production flows when your application needs JSON request bodies, task status lookup, and consistent RunAPI errors in Ruby."
    spec.homepage = "https://runapi.ai/models/flux-2"
    spec.license = "Apache-2.0"
    spec.required_ruby_version = ">= 3.1.0"
    spec.metadata["homepage_uri"] = "https://runapi.ai/models/flux-2"
    spec.metadata["documentation_uri"] = "https://github.com/runapi-ai/flux-2-sdk/blob/main/ruby/README.md"
    spec.metadata["source_code_uri"] = "https://github.com/runapi-ai/flux-2-sdk"
    spec.metadata["changelog_uri"] = "https://github.com/runapi-ai/flux-2-sdk/blob/main/CHANGELOG.md"



    spec.files = Dir.glob("lib/**/*") + %w[LICENSE README.md]
    spec.extra_rdoc_files = ["README.md"]
        spec.require_paths = ["lib"]

    spec.add_dependency "runapi-core", "~> 0.2.5"
  end
end
