class RemoveFabricFromUnits < ActiveRecord::Migration
  def change
    remove_column :units, :fabric, :string
  end
end
