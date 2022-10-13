class RenameColumnofOrders < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :discount_price_in_cents, :price
    rename_column :orders, :loyality_discounted_price, :discount_price
  end
end
