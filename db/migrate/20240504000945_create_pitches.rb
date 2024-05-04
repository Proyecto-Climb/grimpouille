class CreatePitches < ActiveRecord::Migration[7.0]
  def change
    create_table :pitches do |t|
      t.integer :length
      t.integer :position
      t.string :grade
      t.integer :bolts
      t.integer :angle
      t.integer :status
      t.references :route, null: false, foreign_key: true

      t.timestamps
    end
  end
end
