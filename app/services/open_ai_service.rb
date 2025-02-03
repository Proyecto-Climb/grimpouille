# frozen_string_literal: true

client = OpenAI::Client.new

response = client.chat(
  parameters: {
    model: "gpt-4o-mini", # Required.
    response_format: { type: "json_object" },
    messages: [{ role: "user", content: "Give me info on a route called Special Forces in Skaha in JSON format"}], # Required.
    temperature: 0.7,
  }
)
pp response#.dig("choices", 0, "message", "content")
