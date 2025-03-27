class AddDeveloperToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :developer, :boolean, default: false
  end
end
