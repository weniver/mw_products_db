class Remission < ActiveRecord::Base
  belongs_to :store
  has_many :units
end
