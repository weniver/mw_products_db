class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.string :real_color
      t.string :hue
      t.string :tone
      t.string :darkness

      t.timestamps null: false
    end
  end
end
