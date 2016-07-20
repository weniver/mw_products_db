class Pattern < ActiveRecord::Base
  has_many :units

  validates :name, presence: true,
                   uniqueness: true
  validates :code, presence: true,
                   uniqueness: true
end
