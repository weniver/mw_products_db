class CreateRemissions < ActiveRecord::Migration
  def change
    create_table :remissions do |t|
      t.references :store, index: true, foreign_key: true
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
