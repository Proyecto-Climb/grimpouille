class AddReferenceToProvinceInRegions < ActiveRecord::Migration[7.0]
  def change
    add_reference :regions, :province, foreign_key: true, null: false
  end
end
