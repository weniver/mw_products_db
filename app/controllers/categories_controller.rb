class CategoriesController < ApplicationController
  def show
   @category = Category.find_by(id: params[:id])
   @units = @category.units.all
  end
end
