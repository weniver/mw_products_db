class Product < ActiveRecord::Base
  belongs_to :brand
  has_many :categories, dependent: :destroy
  accepts_nested_attributes_for :categories

  default_scope -> { order(created_at: :desc) }

  validates :brand_id, presence: true
  validates :name,     presence: true,
                       length: { maximum: 50 }

  def create_category_from_name
    name = self.name
    self.categories.build(name: name,
                          price: 1234.56)
  end
end
