class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  scope :active, -> { where(active: true) }
  scope :delivered, -> { where('delivered_at IS NOT NULL') }
  scope :paid_and_undelivered_orders, -> { where('paid_at IS NOT NULL AND shipped_at IS NULL') }
  scope :unpaid_orders, -> { where('paid_at IS NULL') }
  scope :shipped_yesterday, -> { where('shipped_at > ?', Date.yesterday.at_midnight) }
  scope :delivered_yesterday, -> { where('delivered_at > ?', Date.yesterday.at_midnight) }
  scope :created_yesterday, -> { where('created_at > ?', Date.yesterday.at_midnight) }

  def send_invoice
    InvoiceSender.call(self)
  end
end
