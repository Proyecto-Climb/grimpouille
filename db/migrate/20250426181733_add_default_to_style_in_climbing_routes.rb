class AddDefaultToStyleInClimbingRoutes < ActiveRecord::Migration[7.0]
  def change
    change_column_default :climbing_routes, :style, 5
  end
end
