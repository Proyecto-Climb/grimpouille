module Api
  module V1
    class ClimbingRoutesController < ApplicationController
      include AI::OpenAIService

      skip_before_action :authenticate_user!, :verify_authenticity_token

      def all_routes_per_sector
        sector = Sector.find_by(id: params[:climbing_route][:sector_id])
        climbing_routes = ClimbingRoute.by_sector(sector) if sector

        if climbing_routes
          render json: climbing_routes, status: :ok
        else
          render json: 'nothing there', status: :not_found
        end
      end

      def training_routes_recommendations
        @project = ClimbingRoute.find_by(id: params[:climbing_route][:id])

        if @project
          training_routes = select_training_routes
          recommended_routes = training_routes#.limit(5)
          @response = enhance_response(@project, recommended_routes)

          render json: { project: { name: @project.name, grade: @project.grade, crag: @project.crag.name }, recommendations: @response }, status: :ok
        else
          render json: { error: "Project route not found" }, status: :not_found
        end
      end

      private

      def climbing_route_params
        require(:climbing_route).permit(:id, :sector_id)
      end
    end
  end
end
