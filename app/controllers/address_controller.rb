class AddressController < ApplicationController
  def create
    user = User.find_by(verification_token: params[:verification_token])
    address = user.addresses.build(permitted_address_params)

    if address.save
      order = logged_in_user_cart_order
      order.shipping_address_id = address.id
      order.save
      redirect_to order_url(logged_in_user_cart_order), notice: t(:successfull, resource_name: 'added shipping address for order')
    else
      redirect_to new_address_url, notice: t(:default_error_message)
    end
  end

  def new
    @address = Address.new
    @order = Order.find(params[:order_id])
  end

  def shipping
    order = Order.find(params[:order_id])
    if order.update(shipping_address_id: permitted_address_params[:shipping_address_id])
      redirect_to order_url(order), notice: t(:successfull, resource_name: 'added shipping address for order')
    else
      redirect_to new_address_url, notice: t(:default_error_message)
    end
  end

  private

    def permitted_address_params
      params.require(:address).permit(:country, :city, :state, :line1, :line2, :postal_code, :shipping_address_id)
    end
end
