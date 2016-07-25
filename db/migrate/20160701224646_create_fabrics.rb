class CreateFabrics < ActiveRecord::Migration
  def change
    create_table :fabrics do |t|
      t.string :material
      t.string :color

      t.timestamps null: false
    end
  end
end
