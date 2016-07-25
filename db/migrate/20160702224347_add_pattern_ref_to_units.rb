class AddPatternRefToUnits < ActiveRecord::Migration
  def change
    add_reference :units, :pattern, index: true, foreign_key: true
  end
end
