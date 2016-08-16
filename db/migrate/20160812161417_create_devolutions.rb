class CreateDevolutions < ActiveRecord::Migration
  def change
    create_table :devolutions do |t|
      t.text :description
      t.references :remission, index: true, foreign_key: true
      t.string :product_code

      t.timestamps null: false
    end
  end
end
