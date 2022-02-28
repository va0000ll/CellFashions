class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :locked_at, :datetime
    add_column :users, :unlock_token, :string
    add_index :users, :unlock_token
  end
end
