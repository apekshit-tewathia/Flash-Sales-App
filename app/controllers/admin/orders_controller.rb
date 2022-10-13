class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.all
    @users = User.all
    if params[:email].present?
      @users = [User.find_by(email: params[:email])]
      @orders = @users.first.orders
    end
  end

  def mark_status
    order_transaction = OrderTransaction.find_by(order_id: params[:order_id])
    order = Order.find(params[:order_id])
    if order_transaction.status == 'paid'
      if permitted_params[:status] == 'In Cart'
        redirect_to order_url(id: params[:order_id]), notice: 'Update not allowed'
      else
        order.update(status: permitted_params[:status].parameterize(separator: '_'))
        redirect_to order_url(id: params[:order_id]), notice: t(:successfull, resource_name: 'updated order status')
      end
    else
      redirect_to order_url(id: params[:order_id]), notice: 'Update not allowed'
    end
  end

  private

    def permitted_params
      params.require(:order).permit(:status)
    end
end
