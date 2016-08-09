class RemovePriceModifierFromUnits < ActiveRecord::Migration
  def change
    remove_column :units, :price_modifier, :decimal
  end
end
