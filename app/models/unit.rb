class Unit < ActiveRecord::Base
  belongs_to :category, dependent: :destroy
  belongs_to :store
  belongs_to :remission
end
