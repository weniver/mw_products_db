class Brand < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :products, dependent: :destroy

  validates :name,  presence: true,
                    length: { maximum: 50 }
end
