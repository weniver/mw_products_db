class AddCodeToPatterns < ActiveRecord::Migration
  def change
    add_column :patterns, :code, :string
  end
end
