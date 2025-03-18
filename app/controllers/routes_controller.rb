# frozen_string_literal: true

class RoutesController < ApplicationController
  include OpenAiService

  skip_before_action :authenticate_user!

  def home
    @routes = Route.order(name: :asc)
  end

  def recommendations
    project = Route.find(params[:route_id])

    if project
      training_routes = Route.where("grade <= ?", project.grade)
                              .order("RANDOM()")

      recommended_routes = training_routes.limit(5)

      response = enhance_response(project, recommended_routes)
      raise

      # schedule = generate_schedule(recommended_routes)

      render json: { project: project.name, recommendations: recommended_routes, schedule: schedule }
    else
      render json: { error: "Project route not found" }, status: :not_found
    end
  end

  private

  def generate_schedule(routes)
    days = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
    routes.each_with_index.map { |route, i| { day: days[i % days.length], route: route.name } }
  end
end
