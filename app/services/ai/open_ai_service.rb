# frozen_string_literal: true

module AI
  module OpenAIService
    ANGLE_MAPPING = {
      'unknown' => [1, 2], # suggest only slab or vertical
      'slab' => [1],
      'vertical' => [1, 2],
      'slight_overhang' => [2, 3],
      'overhang' => [3, 4],
      'roof' => [4, 5]
    }

    def enhance_response(project, recommended_routes)
      client = OpenAI::Client.new

      response = client.chat(
        parameters: {
          model: 'gpt-4o-mini',
          response_format: { type: 'json_object' },
          messages: [
            { role: 'system', content: 'You are a climbing coach recommending training routes. Respond in JSON format.' },
            { role: 'user',
              content: 'Given the following project route and a list of potential training routes, suggest 5 preparatory routes in JSON format and explain your choices briefly.'
            },
            { role: 'user', content: "Project Route (JSON): #{project.attributes.to_json}" },
            { role: 'user', content: "Potential Training Routes (JSON): #{recommended_routes.map(&:attributes).to_json}" }
          ],
          temperature: 0.7
        }
      )

      JSON.parse(response['choices'].first['message']['content'])['preparatory_routes']
    end

    def select_training_routes
      ClimbingRoute.joins(:pitches).where.not(id: @project.id)
        .where(
        standardized_grade: define_grade_range,
        style: @project.style
        ).where(
          pitches: { angle: evaluate_angle(@project.pitch.angle) }
        )
        .order(standardized_grade: :desc)
        .first(5)
    end

    def define_grade_range
      top_grade = @project.standardized_grade
      lowest_grade = top_grade - 4
      (lowest_grade...top_grade)
    end

    def evaluate_angle(project_angle)
      ANGLE_MAPPING[project_angle]
    end
  end
end
