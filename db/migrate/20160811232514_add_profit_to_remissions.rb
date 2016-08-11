class AddProfitToRemissions < ActiveRecord::Migration
  def change
    add_column :remissions, :profit, :decimal
  end
end
