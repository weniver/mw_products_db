class CreateBrandsUsers < ActiveRecord::Migration
  def change
    create_table :brands_users, id: false do |t|
      t.references :brand, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
