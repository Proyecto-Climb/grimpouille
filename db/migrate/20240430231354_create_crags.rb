class CreateCrags < ActiveRecord::Migration[7.0]
  def change
    create_table :crags do |t|
      t.string :name
      t.references :sector, null: false, foreign_key: true

      t.timestamps
    end
  end
end
