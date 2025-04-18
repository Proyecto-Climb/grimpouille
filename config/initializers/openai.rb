# frozen_string_litteral: true

OpenAI.configure do |config|
  config.access_token = ENV.fetch('OPENAI_ACCESS_TOKEN')
  # config.organization_id = ENV.fetch('OPENAI_ORGANIZATION_ID') # Optional
  config.log_errors = true # Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production because it could leak private data to your logs.

  # config.uri_base = "https://oai.hconeai.com/" # Optional
  # config.request_timeout = 240 # Optional
  # config.extra_headers = {
  #   "X-Proxy-TTL" => "43200", # For https://github.com/6/openai-caching-proxy-worker#specifying-a-cache-ttl
  #   "X-Proxy-Refresh": "true", # For https://github.com/6/openai-caching-proxy-worker#refreshing-the-cache
  #   "Helicone-Auth": "Bearer HELICONE_API_KEY" # For https://docs.helicone.ai/getting-started/integration-method/openai-proxy
  # } # Optional
end

# client.models.list =>

# {"object"=>"list",
# "data"=>
#  [{"id"=>"o1-mini-2024-09-12", "object"=>"model", "created"=>1725648979, "owned_by"=>"system"},
#   {"id"=>"dall-e-2", "object"=>"model", "created"=>1698798177, "owned_by"=>"system"},
#   {"id"=>"gpt-4o-mini", "object"=>"model", "created"=>1721172741, "owned_by"=>"system"},
#   {"id"=>"gpt-4o-mini-2024-07-18", "object"=>"model", "created"=>1721172717, "owned_by"=>"system"},
#   {"id"=>"gpt-3.5-turbo", "object"=>"model", "created"=>1677610602, "owned_by"=>"openai"},
#   {"id"=>"gpt-3.5-turbo-0125", "object"=>"model", "created"=>1706048358, "owned_by"=>"system"},
#   {"id"=>"gpt-3.5-turbo-instruct", "object"=>"model", "created"=>1692901427, "owned_by"=>"system"},
#   {"id"=>"babbage-002", "object"=>"model", "created"=>1692634615, "owned_by"=>"system"},
#   {"id"=>"davinci-002", "object"=>"model", "created"=>1692634301, "owned_by"=>"system"},
#   {"id"=>"whisper-1", "object"=>"model", "created"=>1677532384, "owned_by"=>"openai-internal"},
#   {"id"=>"dall-e-3", "object"=>"model", "created"=>1698785189, "owned_by"=>"system"},
#   {"id"=>"text-embedding-3-small", "object"=>"model", "created"=>1705948997, "owned_by"=>"system"},
#   {"id"=>"gpt-3.5-turbo-16k", "object"=>"model", "created"=>1683758102, "owned_by"=>"openai-internal"},
#   {"id"=>"omni-moderation-latest", "object"=>"model", "created"=>1731689265, "owned_by"=>"system"},
#   {"id"=>"omni-moderation-2024-09-26", "object"=>"model", "created"=>1732734466, "owned_by"=>"system"},
#   {"id"=>"tts-1-hd-1106", "object"=>"model", "created"=>1699053533, "owned_by"=>"system"},
#   {"id"=>"o1-mini", "object"=>"model", "created"=>1725649008, "owned_by"=>"system"},
#   {"id"=>"o1-preview", "object"=>"model", "created"=>1725648897, "owned_by"=>"system"},
#   {"id"=>"o1-preview-2024-09-12", "object"=>"model", "created"=>1725648865, "owned_by"=>"system"},
#   {"id"=>"tts-1-hd", "object"=>"model", "created"=>1699046015, "owned_by"=>"system"},
#   {"id"=>"text-embedding-ada-002", "object"=>"model", "created"=>1671217299, "owned_by"=>"openai-internal"},
#   {"id"=>"gpt-3.5-turbo-1106", "object"=>"model", "created"=>1698959748, "owned_by"=>"system"},
#   {"id"=>"tts-1", "object"=>"model", "created"=>1681940951, "owned_by"=>"openai-internal"},
#   {"id"=>"tts-1-1106", "object"=>"model", "created"=>1699053241, "owned_by"=>"system"},
#   {"id"=>"gpt-3.5-turbo-instruct-0914", "object"=>"model", "created"=>1694122472, "owned_by"=>"system"},
#   {"id"=>"text-embedding-3-large", "object"=>"model", "created"=>1705953180, "owned_by"=>"system"}]}
