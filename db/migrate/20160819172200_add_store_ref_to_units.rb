class AddStoreRefToUnits < ActiveRecord::Migration
  def change
    add_reference :units, :store, index: true, foreign_key: true
  end
end
