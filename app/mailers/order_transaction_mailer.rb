class OrderTransactionMailer < ApplicationMailer
  def order_placement_confirmation(order_transaction)
    @order_transaction = order_transaction
    mail to: order_transaction.order.user.email, subject: 'Order Placement Confirmation'
  end
end
