class FabricsController < ApplicationController
  before_action :correct_brand, only: [:edit, :update]

  def new
    @fabric = Fabric.new
  end

  def create
    @fabric = current_brand.fabrics.new(fabric_params)
    #saves both the fabric and the brand name
    if @fabric.save
      # TODO: Redirigir a pagina donde se vea todas las fabrics y los patrones.
      flash[:success] = "La Nueva Tela se Agrego Exitosamente."
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

    def fabric_params
      params.require(:fabric).permit(:material,
                                     :color)
    end

    # Before filters
    def correct_brand
      @product = current_brand.products.find(params[:id])
      redirect_to(root_url) unless correct_brand_for_product?(@product)
    end
end
