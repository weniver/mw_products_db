class UnitsController < ApplicationController
  def index
    @units = Unit.all
  end

  def new
    @unit = Unit.new
    @products = current_brand.products
  end

  def create
    @unit = Unit.new
    @products = current_brand.products
  end
end
