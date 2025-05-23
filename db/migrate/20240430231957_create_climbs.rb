class CreateClimbs < ActiveRecord::Migration[7.0]
  def change
    create_table :climbs do |t|
      t.integer :status
      t.references :climbing_route, null: false, foreign_key: true
      t.references :climber, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
