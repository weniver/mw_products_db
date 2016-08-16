class AddPriceModifierToRemissions < ActiveRecord::Migration
  def change
    add_column :remissions, :price_modifier, :integer, default: 0
  end
end
