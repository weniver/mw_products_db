class AddColorRefToUnits < ActiveRecord::Migration
  def change
    add_reference :units, :color, index: true, foreign_key: true
  end
end
