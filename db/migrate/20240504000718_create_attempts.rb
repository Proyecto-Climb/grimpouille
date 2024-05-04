class CreateAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :attempts do |t|
      t.datetime :date
      t.text :notes
      t.integer :status
      t.references :climb, null: false, foreign_key: true

      t.timestamps
    end
  end
end
