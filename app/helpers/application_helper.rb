module ApplicationHelper
  def user_logged_in?
    User.find_by(id: cookies.encrypted[:user_id]).present?
  end

  def admin_logged_in?
    User.find_by(id: cookies.encrypted[:user_id]).try(:admin?)
  end

  def logged_in_user
    User.find_by(id: cookies.encrypted[:user_id])
  end

  def to_dollar(price)
    price.try(:/, 100)
  end

  def live_deal_exist?(deals)
    return true if deals.first.live?

  end

  def logged_in_user_last_used_shipping_address
    last_used_address = Address.find_by(id: logged_in_user.orders.last.shipping_address_id)
    last_used_address.present? ? last_used_address : logged_in_user.addresses.last
  end

  def logged_in_user_cart_order
    logged_in_user.orders.find_by(status: 'in_cart')
  end
end
