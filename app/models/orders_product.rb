class OrdersProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def self.total_last_24h
    select('SUM(products.price * orders_products.qt) as total').where('orders_products.created_at > ?', 24.hours.ago).joins(:product).to_a.first&.total || 0
  end

  def self.total_last_30d
    select('SUM(products.price * orders_products.qt) as total').where('orders_products.created_at > ?', 30.days.ago).joins(:product).to_a.first&.total || 0
  end

  def self.total_count_last_24h
    select('SUM(qt) as total').where('created_at > ?', 24.hours.ago).to_a.first&.total || 0
  end

  def self.total_count_last_30d
    select('SUM(qt) as total').where('created_at > ?', 30.days.ago).to_a.first&.total || 0
  end
end
