class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :qt

      t.timestamps
    end

    add_index :carts, %i[user_id product_id], unique: true
  end
end
