class AddDefaultColumnValueInOrders < ActiveRecord::Migration[7.0]
  def change
    change_column_default :orders, :price, from: nil, to: 0
    change_column_default :orders, :discount_price, from: nil, to: 0
  end
end
