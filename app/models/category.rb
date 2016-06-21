class Category < ActiveRecord::Base
  belongs_to :product
  has_many :units

  validates :price,    presence: true
  validates :product_id, presence: true
  validates :name,       presence: true,
                         length: { maximum: 50 }
end
