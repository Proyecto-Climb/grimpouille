class AddHeightToClimbingRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :climbing_routes, :height, :integer, default: 0
  end
end
