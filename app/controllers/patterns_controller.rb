class PatternsController < ApplicationController
  before_action :correct_brand, only: [:new, :create, :edit, :update]

  def new
    @pattern = Pattern.new
  end

  def create
    @pattern = current_brand.patterns.new(pattern_params)
    #saves both the pattern and the brand name
    if @pattern.save
      flash[:success] = "El Nuevo Estampado se Agrego Exitosamente."
      redirect_to patterns_url
    else
      render 'new'
    end
  end

  def index
    @patterns = current_brand.patterns.order(:name)
    @fabrics = current_brand.fabrics.all
  end

  def destroy
    Pattern.find(params[:id]).destroy
    flash[:success] = "Estampado Eliminado"
    redirect_to patterns_url
  end

  def edit
    @pattern = Pattern.find(params[:id])
  end

  def update
    @pattern = Pattern.find(params[:id])
    if @pattern.update_attributes(pattern_params)
      flash[:success] = 'Estampado Editado'
      redirect_to patterns_url
    else
      render 'edit'
    end
  end

  private

    def pattern_params
      params.require(:pattern).permit(:name,
                                      :code)
    end

    # Before filters
    def correct_brand
    end
end
