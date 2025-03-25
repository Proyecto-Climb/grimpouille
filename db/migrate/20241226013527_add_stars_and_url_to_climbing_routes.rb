class AddStarsAndUrlToClimbingRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :climbing_routes, :stars, :integer, default: 0
    add_column :climbing_routes, :url, :string
  end
end
