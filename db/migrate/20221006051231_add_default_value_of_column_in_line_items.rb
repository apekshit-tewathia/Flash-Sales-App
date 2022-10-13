class AddDefaultValueOfColumnInLineItems < ActiveRecord::Migration[7.0]
  def change
    change_column_default :line_items, :loyality_discounted_price, from: nil, to: 0
  end
end
