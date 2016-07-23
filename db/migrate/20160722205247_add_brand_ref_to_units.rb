class AddBrandRefToUnits < ActiveRecord::Migration
  def change
    add_reference :units, :brand, index: true, foreign_key: true
  end
end
