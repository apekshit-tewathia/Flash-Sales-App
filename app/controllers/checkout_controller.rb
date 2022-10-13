class CheckoutController < ApplicationController
  before_action :set_transaction, only: [:success, :cancel]
  def checkout
    order = Order.find(params[:id])
    line_items = []

    order.line_items.each do |line_item|
      line_items << {
        price: Stripe::Price.create({
          unit_amount: line_item.deal.discount_price_in_cents,
          currency: 'usd',
          product: Stripe::Product.create({ name: line_item.deal.title }).id,
        }).id,
        quantity: 1
      }
    end

    session = Stripe::Checkout::Session.create({
      line_items: line_items,
      mode: 'payment',
      billing_address_collection: "auto",
      success_url: CGI.unescape(success_url(checkout_session_id: '{CHECKOUT_SESSION_ID}', order_id: order.id)),
      cancel_url: CGI.unescape(cancel_url(checkout_session_id: '{CHECKOUT_SESSION_ID}', order_id: order.id))
    })
    redirect_to session.url, allow_other_host: true
  end

  def success
    if @transaction.save
      if @order.update(placed_at: Time.current, status: :placed)
        @notice = 'Order successfully placed'
      else
        @notice = 'Unable to update order'
      end
    else
      @notice = t(:default_error_message)
    end
  end

  def cancel
    if @transaction.save
      @notice = 'Transaction saved successfully'
    else
      @notice = @transaction.reason
    end
  end

  private
     
    def set_transaction
      transaction = Stripe::Checkout::Session.retrieve({
        id: params[:checkout_session_id],
        expand: ['payment_intent']
      })

      payment_intent = transaction.payment_intent

      @order = Order.find(params[:order_id])
      
      if payment_intent
        payment_error = payment_intent.last_payment_error
        @address = Address.find(@order.shipping_address_id)

        @transaction = OrderTransaction.new(
          order_id: params[:order_id],
          transaction_id: transaction.id,
          payment_intent_id: payment_intent.id,
          amount: transaction.amount_subtotal,
          status: transaction.payment_status,
          code: payment_error.try(:decline_code),
          reason: payment_error.try(:message),
          payment_mode: payment_intent.payment_method_types.first,
          address: @address
        )
      else
        @transaction = OrderTransaction.new(
          order_id: params[:order_id],
          transaction_id: transaction.id,
          status: 'unpaid',
        )        
      end
    end
end
