class RemovePrintStyleFromUnits < ActiveRecord::Migration
  def change
    remove_column :units, :print_style, :string
  end
end
