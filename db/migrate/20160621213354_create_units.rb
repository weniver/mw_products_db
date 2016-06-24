class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :product_code
      t.string :ink_color
      t.string :fabric_color
      t.string :print
      t.decimal :price_modifier, default: 1
      t.boolean :sold, default:false
      t.string :fabric
      t.references :category, index: true, foreign_key: true
      t.references :store, index: true, foreign_key: true
      t.references :remission, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
