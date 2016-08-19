class RemoveStoreRefToUnits < ActiveRecord::Migration
  def change
    remove_reference :units, :store, index: true, foreign_key: true
  end
end
