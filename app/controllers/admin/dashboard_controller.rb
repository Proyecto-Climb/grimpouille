class Admin::DashboardController < ApplicationController
  before_action :find_route, only: [ :show, :edit, :update ]

  def index
    @routes = Route.all
  end

  def show
  end

  def edit
    @angles = Route.angles.map { |str, int| [int, str] }
  end

  def update
    if @route.update(route_params)
      redirect_to admin_route_path(@route)
    else
      render :edit
    end
  end

  private

  def find_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:name, :grade, :style, :stars, :height, :angle)
  end
end
