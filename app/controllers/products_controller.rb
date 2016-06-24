class ProductsController < ApplicationController
  def index
    @products = current_brand.products.paginate(page: params[:page])
  end
end
