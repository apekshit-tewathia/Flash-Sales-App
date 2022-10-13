class AddColumnToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :discount_price_in_cents, :integer
    add_column :orders, :loyality_discounted_price, :integer
  end
end
