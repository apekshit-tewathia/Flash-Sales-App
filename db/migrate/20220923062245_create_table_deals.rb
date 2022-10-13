class CreateTableDeals < ActiveRecord::Migration[7.0]
  def change
    create_table :table_deals do |t|
      t.string :title
      t.string :description
      t.integer :price_in_cents
      t.integer :discount_price_in_cents
      t.integer :quantity
      t.boolean :is_publishable
      t.decimal :tax_percentage
      t.integer :created_by 
      t.datetime :published_at

      t.foreign_key :users, column: :created_by, primary_key: :id

      t.timestamps
    end
  end
end
