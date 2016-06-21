class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :units, :print, :print_style
  end
end
