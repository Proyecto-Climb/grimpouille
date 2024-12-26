class AddStarsAndUrlToRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :routes, :stars, :integer, default: 0
    add_column :routes, :url, :string
  end
end
