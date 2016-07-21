class PatternsController < ApplicationController
  before_action :correct_brand, only: [:new, :create, :edit, :update]

  def new
    @pattern = Pattern.new
  end

  def create
    @pattern = current_brand.patterns.new(pattern_params)
    #saves both the pattern and the brand name
    if @pattern.save
      # TODO: Redirigir a pagina donde se vea todas las patterns y los patrones.
      flash[:success] = "El Nuevo Estampado se Agrego Exitosamente."
      redirect_to root_url
    else
      render 'new'
    end
  end

  # def index
  #   @patterns = current_brand.products.paginate(page: params[:page])
  #   @fabrics =
  # end

  private

    def pattern_params
      params.require(:pattern).permit(:name,
                                      :code)
    end

    # Before filters
    def correct_brand
    end
end
