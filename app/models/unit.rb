class Unit < ActiveRecord::Base
  belongs_to :category, dependent: :destroy
  belongs_to :store
  belongs_to :remission
  belongs_to :fabric
  belongs_to :color
  belongs_to :pattern

  validates :color_id, presence: true
  validates :fabric_id, presence: true
  validates :pattern_id, presence: true

  attr_accessor :product_id, :category_id, :quantity, :colors

  def sold_yes_or_no
    return self.sold ? "Sí" : "No"
  end

  def where_is_it
    id = self.store_id
    return id.nil? ? "Bodega" : "#{Store.find_by(id: id)}"
  end

  def sold_price
    income = self.price_modifier * self.category.price
    return self.sold ? ": #{income.round(2)}" : ""
  end
end
