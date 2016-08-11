class AddProfitToUnits < ActiveRecord::Migration
  def change
    add_column :units, :profit, :decimal, default: nil
  end
end
