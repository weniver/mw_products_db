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

  def add_devolutions(units)
    units.each do |unit|
      description = unit.description
      product_code = unit.product_code
      self.devolutions.create!( description: description,
                                product_code: product_code )
    end
    units.update_all({store_id: nil,
                      remission_id: nil})
  end

  def restore_devolutions
    #gets remission data to update units from devolutions
    @store_id = self.store.id
    @remission_id = self.id
    @to_restore_devs = Devolution.where(remission_id: @remission_id)
    #gets quantity of devolutions for each unit type(via product_code)
    @to_restore_devs_count = @to_restore_devs.group(:product_code).count

    @to_restore_devs_count.each do |code,qty|
      unit = Unit.where(product_code: code, sold: false).limit(qty.to_i)
      unit.update_all( { store_id: @store_id,
                         remission_id: @remission_id } )

    end
    #destroys all devoultions of the remission
    @to_restore_devs.destroy_all
  end
end
