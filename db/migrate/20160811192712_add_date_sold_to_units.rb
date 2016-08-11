class AddDateSoldToUnits < ActiveRecord::Migration
  def change
    add_column :units, :date_sold, :datetime
  end
end
