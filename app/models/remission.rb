class Remission < ActiveRecord::Base
  belongs_to :store
  has_many :units
  validates :store_id, presence: true
  validates_numericality_of :price_modifier, presence: true,
                                             greater_than_or_equal_to: 0,
                                             less_than_or_equal_to: 100,
                                             only_integer: true

  def active_in_words
    return self.active ? "Sí" : "No"
  end
end
