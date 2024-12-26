class AddHeightToRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :routes, :height, :integer, default: 0
  end
end
