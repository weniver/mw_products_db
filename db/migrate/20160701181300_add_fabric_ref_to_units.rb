class AddFabricRefToUnits < ActiveRecord::Migration
  def change
    add_reference :units, :fabric, index: true, foreign_key: true
  end
end
