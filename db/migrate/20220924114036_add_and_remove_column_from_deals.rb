class AddAndRemoveColumnFromDeals < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :status, :string, default: "unpublished"
    remove_column :deals, :published, :boolean
  end
end
