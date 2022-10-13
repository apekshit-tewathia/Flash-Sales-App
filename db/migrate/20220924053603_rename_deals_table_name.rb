class RenameDealsTableName < ActiveRecord::Migration[7.0]
  def change
    rename_table :table_deals, :deals
  end
end
