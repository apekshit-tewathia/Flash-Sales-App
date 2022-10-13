class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :deal

  before_create :calculate_loyality_discount_percentage_and_price

  def calculate_loyality_discount_percentage_and_price
    user_order_number = Order.where(user_id: order.user_id).count
    self.loyality_discount_percentage = [5, user_order_number - 1].min
    self.loyality_discounted_price = self.discounted_price * ((100 - self.loyality_discount_percentage) / 100.0)
  end
end
