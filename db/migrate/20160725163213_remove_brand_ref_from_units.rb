class RemoveBrandRefFromUnits < ActiveRecord::Migration
  def change
    remove_reference :units, :brand, index: true, foreign_key: true
  end
end
