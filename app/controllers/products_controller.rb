class ProductsController < ApplicationController
  before_action :correct_brand, only: [:edit, :update]

  def index
    @products = current_brand.products.paginate(page: params[:page])
  end

  def new
    @product = current_brand.products.new
    @product.categories.build
  end

  def create
    @product = current_brand.products.build(product_params)
    #saves both the product and the categories
    if @product.categories.empty?
      @product.create_category_from_name
      if @product.save
        flash[:info] = "Cuando generas un producto sin categorias, se genera una categoria automaticamente con el mismo nombre del producto. Por favor agrega un precio base o si lo deseas cambia el nombre o agrega mas categorias."
        redirect_to edit_product_url(@product)
      else
        render 'new'
      end
    elsif @product.save
      @product.save
      flash[:info] = "Tu producto se creo exitosamente."
      redirect_to products_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      flash[:success] = "Tu producto se ha modificado."
      redirect_to products_url
    else
      render 'edit'
    end
  end
  private

    def product_params
      params.require(:product).permit(:name,
                                       categories_attributes: [:id, :name, :price])
    end

    # Before filters
    def correct_brand
      @product = current_brand.products.find(params[:id])
      redirect_to(root_url) unless correct_brand_for_product?(@product)
    end
end
