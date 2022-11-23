class ManageOrdersJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    # if there are millions of costumers in the database a nosql db would be better for this use case
    # we can also split the job into multiple jobs(one for each action) and run them in parallel
    Customer.with_active_orders.find_each do |customer|
      @logs = "Nightly routine for customer #{customer.id}...\n"
      # All the orders that have been delivered
      deactivate_delivered_orders(customer)
      #  All the orders that are paid, but need delivery
      ship_paid_orders(customer)
      #  All the orders that are not paid
      reminder_of_payment(customer)
      puts @logs
    end
  end

  private

  def reminder_of_payment(customer)
    return if customer.orders.unpaid_orders.empty?

    customer.orders.unpaid_orders.each do |order|
      if order.created_at.today?
        order.send_invoice unless simulate?
        @logs << "Invoice sent\n"
      else
        ActiveRecord::Base.transaction do
          PaymentReminder.new(order).send
          @logs << "Payment reminder sent\n"
        end
      end
    end
  end

  def ship_paid_orders(customer)
    return if simulate? || customer.orders.paid_and_undelivered_orders.empty?

    customer.orders.paid_and_undelivered_orders.each do |order|
      ActiveRecord::Base.transaction do
        order.product.ship_for(customer)
        order.update_attribute(:shipped_at, Time.now)
      end
    end
  end

  def deactivate_delivered_orders(customer)
    return unless customer.orders.delivered.any?

    customer.orders.delivered.update_all(active: false)
  end

  def simulate?
    ENV['SIMULATE'].present?
  end
end
