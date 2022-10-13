class ChangeColumnTypeInOrders < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :discount_price, :decimal, precision: 10, scale: 2
  end
end
