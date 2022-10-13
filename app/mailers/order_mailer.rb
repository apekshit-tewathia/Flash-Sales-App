class OrderMailer < ApplicationMailer
  def status_update(order, order_transaction)
    @order = order
    @order_transaction = order_transaction
    mail to: order.user.email, subject: 'Update in order status'
  end
end
