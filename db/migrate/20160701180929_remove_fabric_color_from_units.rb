class RemoveFabricColorFromUnits < ActiveRecord::Migration
  def change
    remove_column :units, :fabric_color, :string
  end
end
