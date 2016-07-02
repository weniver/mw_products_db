class Fabric < ActiveRecord::Base
  has_many :units

  def material_and_color
   "#{material} #{color}"
  end
end
