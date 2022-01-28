class Product < ApplicationRecord
  belongs_to :category, optional: true
  has_many :orders_products
  has_many :orders, through: :orders_products
end
