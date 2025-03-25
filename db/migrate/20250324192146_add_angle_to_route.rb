class AddAngleToRoute < ActiveRecord::Migration[7.0]
  def change
    add_column :routes, :angle, :integer, default: 6
  end
end
