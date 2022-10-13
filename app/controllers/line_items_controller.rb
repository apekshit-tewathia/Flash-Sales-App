class LineItemsController < ApplicationController
  def destroy
    line_item = LineItem.find(params[:id])
    if line_item.order.line_items.destroy(line_item)
      notice = t(:successfull, resource_name: 'deleted deal from order')
    else
      notice = t(:default_error_message)
    end
    redirect_to orders_url, notice: notice
  end
end
