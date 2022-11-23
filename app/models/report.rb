class Report
  #
  # This function sends an email to the line manager,
  # containing all the counts of the orders that have been delivered, shipped
  # and all the counts of the unpaid invoices
  #  Please, fix eventual errors, implement what's missing, eventually refactor and optimise
  #
  # @return [<Type>] <description>
  #
  def send_to_line_manager
    get_all_the_delivered_orders
    get_all_the_shipped_orders
    get_all_the_unpaid_invoices

    send_all
  end

  def get_all_the_delivered_orders
    orders = Order.delivered_yesterday
    orders.group_by do |order|
      [order.customer.id, orders.count]
    end.to_h
  end

  # send all the shipped orders
  def get_all_the_shipped_orders
    orders = Order.shipped_yesterday
    orders.group_by do |order|
      [order.customer.id, orders.count]
    end.to_h
  end

  #  Please, implement
  def get_all_the_unpaid_invoices
    orders = Order.unpaid_orders
    orders.group_by do |order|
      [order.customer.id, orders.count]
    end.to_h
  end

  # Do not implement!
  def send_all
    #  Remote Call to the email provider
    # NOTE: this method connects over the network to our invoicing system and could throw a Timeout::Error
  end
end
