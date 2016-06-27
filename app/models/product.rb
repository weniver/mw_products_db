class Product < ActiveRecord::Base
  belongs_to :brand
  has_many :categories, dependent: :destroy
  accepts_nested_attributes_for :categories

  default_scope -> { order(created_at: :desc) }

  validates :brand_id, presence: true
  validates :name,     presence: true,
                       length: { maximum: 50 }
end
