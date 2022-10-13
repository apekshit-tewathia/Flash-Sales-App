class AddColumnsToOrderTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :order_transactions, :payment_intent_id, :string
    add_column :order_transactions, :amount, :decimal, precision: 10, scale: 2
  end
end
