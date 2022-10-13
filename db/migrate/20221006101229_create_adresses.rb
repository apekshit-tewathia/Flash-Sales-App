class CreateAdresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :country
      t.string :line1
      t.string :line2
      t.integer :postal_code
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
