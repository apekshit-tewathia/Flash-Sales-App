class CreateTableOrderTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :order_transactions do |t|
      t.references :order, null: false, foreign_key: true
      t.string :transaction_id
      t.string :status
      t.references :shipping_address, null: false, foreign_key: { to_table: :addresses }
      t.string :code
      t.string :reason
      t.string :payment_mode

      t.timestamp :created_at, null: false
    end
  end
end
