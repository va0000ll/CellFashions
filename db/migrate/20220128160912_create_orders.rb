class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :products_count
      t.string :status

      t.timestamps
    end
  end
end
