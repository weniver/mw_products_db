class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.decimal :price
      t.boolean :out_of_stock, default: false
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
