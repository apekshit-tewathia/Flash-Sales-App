class OrdersController < ApplicationController
  def index
    @orders = logged_in_user.orders
  end

  def show
    @order = Order.find(params[:id])
    @shipping_address = Address.find_by(id: @order.try(:shipping_address_id))
  end

  def create
    order = Order.find_or_initialize_by(status: :in_cart, user_id: logged_in_user.id)
    deal = Deal.find(permitted_params[:deal_id])
    notice = ''
    line_item = LineItem.find_or_initialize_by(deal_id: permitted_params[:deal_id], quantity: permitted_params[:quantity], order_id: order.id, discounted_price: deal.discount_price_in_cents)
    if order.persisted?
      if line_item.persisted?
        redirect_to deals_url(status: 'live'), notice: 'Deal already present in the buying list' and return
      else
        order.line_items << line_item
        redirect_to order_url(order), notice: 'Successfully added deal in the buying list'
      end
    else
      if logged_in_user.line_items.exists?(deal_id: permitted_params[:deal_id])
        redirect_to deals_url(status: 'live'), notice: 'Not allowed to buy this deal'
      else
        if order.save
          order.line_items << line_item
          redirect_to order_url(order), notice: 'Successfully added deal in the buying list'
        else
          redirect_to deals_url(status: 'live'), notice: t(:default_error_message)
        end
      end
    end
  end

  def edit
  end

  def update
  end

  def cancel
    order = Order.find(params[:order_id])
    
    if order.update(status: 'cancelled')
      redirect_to order_url(order), notice: 'Successfully cancelled order'
    else
      redirect_to order_url(order), notice(:default_error_message)
    end
  end

  def destroy
  end

  private

    def permitted_params
      params.require(:order).permit(:deal_id, :quantity)
    end
end
