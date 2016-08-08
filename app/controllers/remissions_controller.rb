class RemissionsController < ApplicationController
  before_action :correct_brand, only: [:edit, :update, :destroy]

  def new
    @remission = Remission.new
    @stores = Store.all
    @units = Unit.all
  end

  def create
    # TODO: validate that you select at least 1 unit
    # TODO: Not working correctlly in dynamic table
    @remission = Remission.new(remission_params)
    #saves both the user and the brand name
    if @remission.save
      Unit.where(id: params[:unit_ids]).update_all({store_id: @remission.store.id,
                                                    remission_id: @remission.id})
      flash[:success] = "Remissión creada. Las piezas se movieron de la bodega a #{@remission.store.name}"
      redirect_to remission_url(@remission)
    else
      @stores = Store.all
      @units = Unit.all
      render 'new'
    end
  end

  def index
    @remissions = Remission.all
  end

  def destroy
    @remission = Remission.find(params[:id])
    @units = @remission.units.all
    #Returns the products to Storage as they did not change location.
    @units.update_all({store_id: nil,
                       remission_id: nil})
    @remission.destroy
    flash[:success] = "Remisión Borrada. Las piezas se regresaron a la bodega."
    redirect_to remissions_url
  end

  def show
    @remission = Remission.find(params[:id])
    @units = @remission.units
  end

  def edit
  end

  def update
  end

  def sold
    Unit.where.not(id: params[:unit_ids]).update_all(sold: false)
    Unit.where(id: params[:unit_ids]).update_all(sold: true)
    redirect_to :back
  end

  def download
    @remission = Remission.find(params[:id])
    @units = @remission.units
    name_of_file="R-#{@remission.id.to_s}_#{@remission.store.name}_#{@remission.created_at.strftime("%H-%I-%G")}"
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=#{name_of_file}.xlsx"
      }

    end
  end

  private

    def remission_params
      params.require(:remission).permit( :store_id )
    end

    # Before filters
    def correct_brand
      @brand = current_brand
      @remission = Remission.find(params[:id])
      @remission_brand = @remission.units.first.category.product.brand
      redirect_to(root_url) unless @brand == @remission_brand
    end
end
