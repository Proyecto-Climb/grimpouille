class AddAngleToClimbingRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :climbing_routes, :angle, :integer, default: 6
  end
end
