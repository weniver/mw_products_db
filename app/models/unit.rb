class Unit < ActiveRecord::Base
  include ProductsHelper

  belongs_to :category
  belongs_to :store
  belongs_to :remission
  belongs_to :fabric
  belongs_to :color
  belongs_to :pattern
  belongs_to :batch

  before_save :create_unit_code

  validates :color_id, presence: true
  validates :fabric_id, presence: true
  validates :pattern_id, presence: true
  validate  :extra_validations
  attr_accessor :product_id, :quantity, :colors, :edit_all_batch, :into_remission

  def pattern_color_in_words
    return self.color.color_in_words
  end

  def description
    pro = self.category.product.name
    cat = self.category.name
    if self.pattern.name == 'Varios'
      pat = self.pattern.name
      hue_fab = ''
    elsif pro == 'Relleno'
      hue_fab = ''
      pat = ''
    else
      pat = self.pattern.name
      hue = self.color.hue_for_description
      fab = self.fabric.material_and_color
      hue_fab = "#{hue}/#{fab}"
    end
    desc = "#{pro} #{cat} #{pat} #{hue_fab}"
    return desc.upcase
  end

  def pattern_color_tables
    if self.category.product.name == 'Relleno'
      pat_col = 'n/a'
    elsif self.pattern.name == 'Varios'
      pat_col = 'Varios'
    else
      pat_col = self.pattern.name + self.color.real_color
    end
  end

  def fabric_table
    if self.fabric.material == 'n/a'
      fabric = 'n/a'
    else
      fabric = self.fabric.material + self.fabric.color.capitalize
    end
  end

  def where_is_it
    id = self.store_id
    return id.nil? ? "Bodega" : "#{Store.find_by(id: id).name}"
  end

  def real_price
    unless self.remission_id.nil?
      percentage_of_price_multiplier= (100 - self.remission.price_modifier)/100.0
      unit_real_price = (percentage_of_price_multiplier * self.category.price).round(2).to_d
    else
      self.category.price.to_d
    end
  end

  #sets sold price or n/a, for tables
  def sold_price_or_na
    return self.sold ? "$ #{self.profit}": "n/a"
  end

  #updates product if sold
  def sold_data
    profit = self.real_price
    self.update_columns({sold: true, profit: profit, date_sold: Time.now})
  end

  def create_unit_code
    #relleno dont have color nor pattern
    if self.category.product.name == 'Relleno'
      code = code_product + code_category
    #in varios the pattern is not importante
    elsif self.pattern.name == 'Varios'
      code = code_product + code_category + self.pattern.code + special_code_fabric
    else
      code = code_product + code_category + self.pattern.code + self.color.real_color + special_code_fabric
    end
    self.product_code = code.upcase.delete(' ')
  end

  def create_units_batch
      if self.quantity.to_i > 1
        Batch.create!
        self.batch_id = Batch.maximum(:id)
      end
  end

  private
    def extra_validations
      if self.quantity.blank?
        self.errors[:base] << "Quantity can't be blank"
      end
      if self.product_id.blank?
        self.errors[:base] << "You need to select a product"
      end
      if self.category_id.blank?
        self.errors[:base] << "You need to select a category"
      end
      if self.colors.blank?
        self.errors[:base] << "You need to select a color"
      end
      if self.quantity == '0'
        self.errors[:base] << "Quanity can't be zero"
      end
      unless self.quantity.to_f % 1 == 0
        self.errors[:base] << "Quanity needs to be an integer"
      end
      if self.quantity.to_f.negative?
        self.errors[:base] << "Quanity needs to be positive"
      end
    end

    def code_product
      self.category.product.name[0...3]
    end

    def code_category
      if category_is_product_name(self.category)
        return ''
      else
        return self.category.name.first
      end
    end

    def special_code_fabric
      if self.fabric.material == "Lino"
        return 'L'
      else
        return ''
      end
    end
end
