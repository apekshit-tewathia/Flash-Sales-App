class CreateTableOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :status
      t.datetime :placed_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
