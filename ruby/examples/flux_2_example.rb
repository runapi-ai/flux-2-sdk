#!/usr/bin/env ruby
# frozen_string_literal: true

require "runapi/flux_2"

client = RunApi::Flux2::Client.new(
  api_key: ENV.fetch("RUNAPI_API_KEY", "runapi_test_token"),
  base_url: ENV.fetch("RUNAPI_BASE_URL", "https://runapi.ai")
)

# 1. Text-to-image (Pro)
puts "=== Pro Text-to-Image ==="
result = client.text_to_image.run(
  model: "flux-2-pro-text-to-image",
  prompt: "a serene mountain lake at sunset",
  aspect_ratio: "16:9",
  output_resolution: "2k"
)
puts "Status: #{result["status"]}"
puts "Images: #{result["images"]}"

# 2. Text-to-image (Flex)
puts "\n=== Flex Text-to-Image ==="
result = client.text_to_image.run(
  model: "flux-2-flex-text-to-image",
  prompt: "cyberpunk cityscape at night",
  aspect_ratio: "1:1",
  output_resolution: "1k"
)
puts "Status: #{result["status"]}"
puts "Images: #{result["images"]}"

# 3. Remix image mode (Max)
puts "\n=== Max Remix Image ==="
result = client.remix_image.run(
  model: "flux-2-max-remix-image",
  prompt: "transform into watercolor painting style",
  source_image_urls: ["https://cdn.runapi.ai/public/samples/image.jpg"],
  aspect_ratio: "3:4",
  output_resolution: "1k",
  output_count: 1
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
    model: "flux-2-pro-remix-image",
    prompt: "test"
  )
rescue RunApi::Core::ValidationError => e
  puts "Caught ValidationError: #{e.message}"
end
