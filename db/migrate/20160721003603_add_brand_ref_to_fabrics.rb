class AddBrandRefToFabrics < ActiveRecord::Migration
  def change
    add_reference :fabrics, :brand, index: true, foreign_key: true
  end
end
