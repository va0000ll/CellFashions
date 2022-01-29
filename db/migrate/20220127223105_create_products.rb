class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.text :keywords
      t.decimal :price, default: 0, precision: 8, scale: 2
      t.integer :category_id

      t.timestamps
    end
  end
end
