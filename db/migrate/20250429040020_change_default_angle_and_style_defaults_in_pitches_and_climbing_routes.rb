class ChangeDefaultAngleAndStyleDefaultsInPitchesAndClimbingRoutes < ActiveRecord::Migration[7.0]
  def change
    change_column_default :climbing_routes, :style, 0
    change_column_default :pitches, :angle, 0
  end
end
