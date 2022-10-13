class Order < ApplicationRecord
  include ActiveModel::Dirty

  define_attribute_methods

  has_many :line_items, dependent: :destroy, after_add: :calculate_price_and_discount_price_on_add, after_remove: :calculate_price_and_discount_price_on_remove, before_add: :prevent_multiple_purchase_of_same_deal, autosave: true
  belongs_to :user
  has_one :order_transaction, dependent: :destroy
  has_many :deals, through: :line_items
  belongs_to :shipping_address, class_name: 'Address', optional: true

  enum status: [ :in_cart, :placed, :in_transit, :out_for_delivery, :shipped, :delivered, :cancelled ]

  after_update :cancel_and_refund_order, if: :cancelled?
  after_update :send_status_updation_mail

  # validates :discount_price_in_cents, :loyality_discounted_price, numericality: true, allow_blank: true

  def calculate_price_and_discount_price_on_add(line_item)
    self.price += line_item.discounted_price
    self.discount_price += line_item.loyality_discounted_price
    self.save

    line_item.deal.quantity -= 1
    line_item.deal.save
  end

  def calculate_price_and_discount_price_on_remove(line_item)
    self.price -= line_item.discounted_price
    self.discount_price-= line_item.loyality_discounted_price
    if self.price == 0
      self.destroy
    else
      self.save
    end

    line_item.deal.quantity += 1
    line_item.deal.save
  end

  def prevent_multiple_purchase_of_same_deal(line_item)
    self.user.orders.each do |order|
      order.line_items.each do |user_line_item|
        throw :abort if user_line_item.deal_id == line_item.deal_id
      end
    end
  end

  def cancel_and_refund_order
    self.line_items.each do |line_item|
      line_item.deal.quantity += 1
      line_item.deal.save
    end
    p self.order_transaction
    Stripe::Refund.create({payment_intent: self.order_transaction.payment_intent_id, amount: self.order_transaction.amount.to_i})
    self.order_transaction.update(status: 'refunded')
  end

  def send_status_updation_mail
    OrderMailer.status_update(self, self.order_transaction).deliver_now
  end
end
