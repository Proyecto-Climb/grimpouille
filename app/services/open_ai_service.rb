# frozen_string_literal: true

module OpenAiService
  def enhance_response(project, recommended_routes)
    client = OpenAI::Client.new

    response = client.chat(
      parameters: {
        model: 'gpt-4o-mini',
        response_format: { type: 'json_object' },
        messages: [
          { role: 'system', content: 'You are a climbing coach recommending training routes. Respond in JSON format.' },
          { role: 'user', content: 'Given the following project route and a list of potential training routes, suggest 5 preparatory routes in JSON format and explain your choices briefly.' },
          { role: 'user', content: "Project Route (JSON): #{project.attributes.to_json}" },
          { role: 'user', content: "Potential Training Routes (JSON): #{recommended_routes.map(&:attributes).to_json}" }
        ],
        temperature: 0.7,
      }
    )

    JSON.parse(response['choices'].first['message']['content'])['preparatory_routes']
  end
end
