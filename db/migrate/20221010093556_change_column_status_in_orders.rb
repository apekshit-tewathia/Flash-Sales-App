class ChangeColumnStatusInOrders < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :status, :integer
  end
end
