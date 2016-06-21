class Unit < ActiveRecord::Base
  belongs_to :category
  belongs_to :store
  belongs_to :remission
end
