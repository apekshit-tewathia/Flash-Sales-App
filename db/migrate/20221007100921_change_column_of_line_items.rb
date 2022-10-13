class ChangeColumnOfLineItems < ActiveRecord::Migration[7.0]
  def change
    change_column :line_items, :loyality_discounted_price, :decimal, precision: 10, scale: 2
  end
end
