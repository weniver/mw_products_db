class Remission < ActiveRecord::Base
  belongs_to :store
  has_many :units
  validates :store_id, presence: true

  def active_in_words
    return self.active ? "Sí" : "No"
  end
end
