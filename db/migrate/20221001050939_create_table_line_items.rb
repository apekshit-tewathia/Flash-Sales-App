class CreateTableLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.references :deal, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :quantity
      t.integer :discounted_price
      t.integer :loyality_discounted_price
      t.integer :loyality_discount_percentage

      t.timestamps
    end
  end
end
