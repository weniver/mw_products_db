class AddOutOfStockToFabric < ActiveRecord::Migration
  def change
    add_column :fabrics, :out_of_stock, :boolean, default: false
  end
end
