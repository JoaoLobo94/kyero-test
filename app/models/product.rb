
class Product < ApplicationRecord
  has_many :orders

  def ship_for(customer)
    ProductCarrier.deliver(self, customer.address)
  end
end