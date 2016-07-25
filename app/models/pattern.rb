class Pattern < ActiveRecord::Base
  has_many :units
  belongs_to :brand

  validates :name, presence: true,
                   uniqueness: true
  validates :code, presence: true,
                   uniqueness: true
  validates :brand_id, presence: true

end
