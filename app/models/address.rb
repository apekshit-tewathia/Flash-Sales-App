class Address < ApplicationRecord
  has_many :order_transactions, foreign_key: 'shipping_address_id'
  has_many :orders, foreign_key: 'shipping_address_id'
  belongs_to :user

  def to_s
    "#{[country, line1, line2, city, state, postal_code].join(', ')}"
  end
end
