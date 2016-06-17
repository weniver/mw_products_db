class Brand < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :name,  presence: true,
                    length: { maximum: 50 }
end
