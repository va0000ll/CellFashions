class Order < ApplicationRecord
  belongs_to :user
  has_many :orders_products, dependent: :destroy
  has_many :products, through: :orders_products

  def self.total_count_last_24h
    where('created_at > ?', 24.hours.ago).count
  end

  def self.total_count_last_30d
    where('created_at > ?', 30.days.ago).count
  end
end
