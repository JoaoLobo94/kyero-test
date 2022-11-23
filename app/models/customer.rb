class Customer < ApplicationRecord
  has_many :orders
  scope :with_active_orders, -> { joins(:orders).where(orders: { active: true }).distinct }
end