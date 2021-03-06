class Fabric < ActiveRecord::Base
  has_many :units
  belongs_to :brand

  validates :material, presence: true
  validates :color,    presence: true
  validates :material, uniqueness: {scope: :color}
  validates :brand_id, presence: true

  def material_and_color
   "#{material} #{color}"
  end
end
