class Devolution < ActiveRecord::Base
  belongs_to :remission

  validates :description, presence: true
  validates :product_code, presence: true
  validates :remission_id, presence: true
end
