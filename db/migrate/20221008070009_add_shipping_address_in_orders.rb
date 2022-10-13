class AddShippingAddressInOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :shipping_address, foriegn_key: { to_table: :addresses }
  end
end
