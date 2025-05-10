class RemoveAngleFromClimbingRoutes < ActiveRecord::Migration[7.0]
  def change
    remove_column :climbing_routes, :angle, :integer
  end
end
