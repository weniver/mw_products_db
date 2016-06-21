class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :rfc
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
