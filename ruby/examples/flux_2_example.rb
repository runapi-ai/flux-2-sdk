#!/usr/bin/env ruby
# frozen_string_literal: true

require "runapi/flux_2"

client = RunApi::Flux2::Client.new(
  api_key: ENV.fetch("RUNAPI_API_KEY", "runapi_test_token"),
  base_url: ENV.fetch("RUNAPI_BASE_URL", "http://localhost:3000")
)

# 1. Text-to-image (Pro)
puts "=== Pro Text-to-Image ==="
result = client.text_to_image.run(
  model: "flux-2-pro-text-to-image",
  prompt: "a serene mountain lake at sunset",
  aspect_ratio: "16:9",
  resolution: "2K"
)
puts "Status: #{result["status"]}"
puts "Images: #{result["images"]}"

# 2. Text-to-image (Flex)
puts "\n=== Flex Text-to-Image ==="
result = client.text_to_image.run(
  model: "flux-2-flex-text-to-image",
  prompt: "cyberpunk cityscape at night",
  aspect_ratio: "1:1",
  resolution: "1K"
)
puts "Status: #{result["status"]}"
puts "Images: #{result["images"]}"

# 3. Image-to-image mode
puts "\n=== Image-to-Image ==="
result = client.text_to_image.run(
  model: "flux-2-pro-image-to-image",
  prompt: "transform into watercolor painting style",
  input_urls: [ "https://example.com/photo.jpg" ],
  aspect_ratio: "auto"
)
puts "Status: #{result["status"]}"
puts "Images: #{result["images"]}"

# 4. Manual polling (create + get)
puts "\n=== Manual Polling ==="
task = client.text_to_image.create(
  model: "flux-2-flex-text-to-image",
  prompt: "a golden retriever in a field"
)
puts "Task ID: #{task["id"]}"

loop do
  status = client.text_to_image.get(task["id"])
  puts "Polling... status=#{status["status"]}"
  break if status["status"] == "completed" || status["status"] == "failed"

  sleep 2
end

# 5. Error handling
puts "\n=== Error Handling ==="
begin
  client.text_to_image.create(model: "invalid-model", prompt: "test")
rescue RunApi::Core::ValidationError => e
  puts "Caught ValidationError: #{e.message}"
end

begin
  client.text_to_image.create(
    model: "flux-2-pro-image-to-image",
    prompt: "test without input_urls"
  )
rescue RunApi::Core::ValidationError => e
  puts "Caught ValidationError: #{e.message}"
end
