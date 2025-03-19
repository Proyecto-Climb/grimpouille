# frozen_string_literal: true

class RoutesController < ApplicationController
  include OpenAiService

  skip_before_action :authenticate_user!
  before_action :defined_routes

  def home; end

  def recommendations
    project = Route.find_by(id: params[:route_id])

    if project
      training_routes = Route.where(grade: ..project.grade)
                             .order("RANDOM()")

      recommended_routes = training_routes.limit(5)

      @response = enhance_response(project, recommended_routes)

      # render json: { project: project.name, recommendations: recommended_routes, schedule: schedule }
    else
      # render json: { error: "Project route not found" }, status: :not_found
      @error_message = 'Couldn\'t find your project 😕'
    end

    render :home
  end

  private

  def defined_routes
    @defined_routes ||= Route.order(name: :asc)
  end

  def generate_schedule(routes)
    days = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
    routes.each_with_index.map { |route, i| { day: days[i % days.length], route: route.name } }
  end
end
