class CreateOrdersProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :orders_products do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :qt

      t.timestamps
    end
  end
end
