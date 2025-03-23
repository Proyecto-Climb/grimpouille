class AddStandardizedGradeToRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :routes, :standardized_grade, :integer
  end
end
