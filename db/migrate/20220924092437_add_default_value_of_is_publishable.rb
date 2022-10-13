class AddDefaultValueOfIsPublishable < ActiveRecord::Migration[7.0]
  def change
    change_column_default :deals, :is_publishable, from: nil, to: false
    add_column :deals, :published, :boolean, default: false
  end
end
