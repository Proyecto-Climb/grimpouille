class RenameGradeInPitches < ActiveRecord::Migration[7.0]
  def change
    rename_column(:pitches, :grade, :pitch_grade)
  end
end
