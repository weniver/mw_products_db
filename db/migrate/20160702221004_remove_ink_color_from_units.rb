class RemoveInkColorFromUnits < ActiveRecord::Migration
  def change
    remove_column :units, :ink_color, :string
  end
end
