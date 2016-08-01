class AddBatchRefToUnits < ActiveRecord::Migration
  def change
    add_reference :units, :batch, index: true, foreign_key: true
  end
end
