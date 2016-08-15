class StoresController < ApplicationController
  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    #saves both the store and the brand name
    if @store.save
      flash[:success] = "La Tienda se Creo Exitosamente."
      redirect_to stores_url
    else
      render 'new'
    end
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])
    if @store.update_attributes(store_params)
      flash[:success] = "Los Datos de la Tienda se Modificaron Exitosamente."
      redirect_to @store
    else
      render 'edit'
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    flash[:success] = "La Tienda Junto con Todos sus Registros se Elimino."
    redirect_to stores_url
  end

  def index
    @stores = Store.all
  end

  def show
    @store = Store.find(params[:id])
    @remissions = @store.remissions
    @active_remissions = @remissions.where(active: true)
  end

  def download
    @store = Store.find(params[:id])
    @remissions = @store.remissions.where(active: true)
    @remission = @remissions.first

    name_of_file="I-#{@store.name}_#{Time.now.strftime("%H-%I-%G")}"
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=#{name_of_file}.xlsx"
      }
    end
  end


# @remissions = @store.remissions
# @remission = @remissions.first
# @active_remissions = @remissions.where(active: true)
# @ids = @active_remissions.ids.join(', ')
# @all_units = @active_remissions.joins(:units)
private

  def store_params
    params.require(:store).permit(:name,
                                  :address,
                                  :rfc,
                                  :phone,
                                  :email)
  end
end
