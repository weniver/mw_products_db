class Product < ActiveRecord::Base
  belongs_to :brand
  has_many :categories, dependent: :destroy

  validates :brand_id, presence: true
  validates :name,     presence: true,
                       length: { maximum: 50 }
end
