class Unit < ActiveRecord::Base
  belongs_to :category, dependent: :destroy
  belongs_to :store
  belongs_to :remission
  belongs_to :fabric
  belongs_to :color
  belongs_to :pattern
  belongs_to :brand

  before_save :create_unit_code

  validates :color_id, presence: true
  validates :fabric_id, presence: true
  validates :pattern_id, presence: true
  validate :extra_validations

  include ProductsHelper

  attr_accessor :product_id, :quantity, :colors

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

  def create_unit_code
    code = code_product + code_category + self.pattern.code + self.color.real_color + special_code_fabric
    self.product_code = code.upcase.delete(' ')
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
