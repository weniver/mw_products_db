class Remission < ActiveRecord::Base
  belongs_to :store
  has_many :units
  has_many :devolutions, dependent: :destroy

  validates :store_id, presence: true
  validates_numericality_of :price_modifier, presence: true,
                                             greater_than_or_equal_to: 0,
                                             less_than_or_equal_to: 100,
                                             only_integer: true

  def active_in_words
    return self.active ? "Sí" : "No"
  end

  def add_devolutions
    not_sold = self.units.where(sold: false)
    not_sold.each do |unit|
      description = unit.description
      product_code = unit.product_code
      self.devolutions.create!( description: description,
                                product_code: product_code )
    end
  end

  def restore_devolutions
    devolutions = self.devolutions.all
    store_id = self.store.id
    id = self.id
    devolutions.each do |devolution|
      code = devolution.product_code
      unit = Unit.where(product_code: code, sold: false).first
      #if there are not units like that in storage
      if unit == 0
        next
      else
        devolution.destroy
        unit.update_columns( {store_id: store_id,
                              remission_id: id} )
      end
    end
  end
end
