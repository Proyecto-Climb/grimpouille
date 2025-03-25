class AddStandardizedGradeToClimbingRoutes < ActiveRecord::Migration[7.0]
  def change
    add_column :climbing_routes, :standardized_grade, :integer
  end
end
