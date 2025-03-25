class Admin::DashboardController < ApplicationController
  before_action :find_climbing_route, only: [ :show, :edit, :update ]

  def index
    @climbing_routes = ClimbingRoute.all
  end

  def show
  end

  def edit
    @styles = ClimbingRoute.styles.keys
    @angles = ClimbingRoute.angles.keys
  end

  def update
    if @climbing_route.update(route_params)
      redirect_to admin_route_path(@climbing_route)
    else
      render :edit
    end
  end

  private

  def find_climbing_route
    @climbing_route = ClimbingRoute.find(params[:id])
  end

  def route_params
    params.require(:climbing_route).permit(:name, :grade, :style, :stars, :height, :angle)
  end
end
