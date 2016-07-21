class AddBrandRefToPatterns < ActiveRecord::Migration
  def change
    add_reference :patterns, :brand, index: true, foreign_key: true
  end
end
