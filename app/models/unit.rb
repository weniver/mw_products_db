class Unit < ActiveRecord::Base
  belongs_to :category, dependent: :destroy
  belongs_to :store
  belongs_to :remission

  validates :ink_color, presence: true
  validates :fabric_color, presence: true
  validates :print_style, presence: true
  validates :fabric, presence: true
end
