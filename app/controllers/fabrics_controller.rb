class FabricsController < ApplicationController
  before_action :correct_brand, only: [:destroy, :edit, :update]

  def new
    @fabric = Fabric.new
  end

  def create
    @fabric = current_brand.fabrics.new(fabric_params)
    #saves both the fabric and the brand name
    if @fabric.save
      # TODO: Redirigir a pagina donde se vea todas las fabrics y los patrones.
      flash[:success] = "La Nueva Tela se Agrego Exitosamente."
      redirect_to patterns_url
    else
      render 'new'
    end
  end

  def destroy
    Fabric.find(params[:id]).destroy
    flash[:success] = "Tela Eliminada"
    redirect_to patterns_url
  end

  def edit
    @fabric = Fabric.find(params[:id])
  end

  def update
    @fabric = Fabric.find(params[:id])
    if @fabric.update_attributes(fabric_params)
      flash[:success] = 'Tela Editada'
      redirect_to patterns_url
    else
      render 'edit'
    end
  end

  private

    def fabric_params
      params.require(:fabric).permit(:material,
                                     :color)
    end

    # Before filters
    def correct_brand
      @fabric = Fabric.find(params[:id])
      redirect_to(root_url) unless @fabric.brand == current_brand
    end
end
