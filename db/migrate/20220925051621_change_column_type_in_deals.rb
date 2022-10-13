class ChangeColumnTypeInDeals < ActiveRecord::Migration[7.0]
  def change
    change_column :deals, :published_at, :date
  end
end
