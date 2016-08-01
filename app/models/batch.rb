class Batch < ActiveRecord::Base
  has_many :units, dependent: :destroy
end
