class RemissionsController < ApplicationController
  before_action :correct_brand, only: [:edit, :update, :destroy]

  def new
    @remission = Remission.new
    @stores = Store.all
    @units = []
    preunits = Unit.where(sold:false, remission_id: nil).select(:product_code).distinct
    preunits.each do |preunit|
      code = preunit.product_code
      unit = Unit.where(sold: false, product_code: code, remission_id: nil).first
      @units << unit
    end
  end

  def create
    #Units to add to remission based on quantities selected.
    @selected_quantities = params[:quantities].delete_if {|k,v| v == "0"}

    @remission = Remission.new(remission_params)
    #saves both the user and the brand name
    if @remission.save
      @selected_quantities.each do |code,qty|
        @selected_units = Unit.where(sold: false, product_code: code, remission_id: nil).limit(qty.to_i)
        @selected_units.update_all( { store_id: @remission.store.id,
                                      remission_id: @remission.id } )
      end

      flash[:success] = "Remissión creada. Las piezas se movieron de la bodega a #{@remission.store.name}"
      redirect_to remission_url(@remission)
    else
      @stores = Store.all
      @units = []
      preunits = Unit.where(sold:false, remission_id: nil).select(:product_code).distinct
      preunits.each do |preunit|
        code = preunit.product_code
        unit = Unit.where(sold: false, product_code: code, remission_id: nil).first
        @units << unit
      end
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
    unless @units.nil?
      @units.update_all({store_id: nil,
                         remission_id: nil})
    end

    @remission.destroy
    flash[:success] = "Remisión Borrada. Las piezas se regresaron a la bodega."
    redirect_to remissions_url
  end

  def show
    @remission = Remission.find(params[:id])
    @units = @remission.units.order(:product_code)
    @devolutions = @remission.devolutions
  end

  def edit
    @remission = Remission.find(params[:id])
    @remission_units = @remission.units

    @rem_units_qtys = @remission_units.select("COUNT(product_code) as total, product_code").
                                                                       group(:product_code).
                                                                       map{|p| {p.product_code => p.total} }
    #transform [{}] into {}
    @rem_units_qtys = @rem_units_qtys.reduce Hash.new, :merge
    @stores = Store.all

    @units = []
    rem_codes = []
    preunits = @remission_units.select(:product_code).distinct
    preunits.each do |preunit|
      code = preunit.product_code
      rem_codes << code
      unit = Unit.where(sold: false, product_code: code).first
      @units << unit
    end
    #TODO: Fix bug where a unit not part of the remission gets in the middle of remission items when there are only 2 kinds of units in the remission
    restunits = Unit.where(sold:false, remission_id:nil).where.not(product_code: rem_codes).select(:product_code).distinct
    restunits.each do |restunit|
      code = restunit.product_code
      unit = Unit.where(sold: false, product_code: code, remission_id: nil).first
      @units << unit
    end
  end

  def update
    @remission = Remission.find(params[:id])
    #takes out all products with value 0 in select
    @selected_quantities = params[:quantities].delete_if {|k,v| v == "0"}
    if @remission.update_attributes(remission_params)
      @remission.units.update_all( {remission_id: nil,
                                    store_id: nil} )
      #adds all products to remission being edited
      @selected_quantities.each do |code,qty|
        @selected_units = Unit.where(sold: false, product_code: code, remission_id: nil).limit(qty.to_i)
        @selected_units.update_all( { store_id: @remission.store.id,
                                      remission_id: @remission.id } )
      end
      flash[:success] = 'Remisión Editada'
      redirect_to @remission
    else
      render 'edit'
    end
  end

  def sold
    @remission = Remission.find(params[:id])
    #to change deselected items sold
    @remission.units.where.not(id: params[:unit_ids]).update_all(sold: false, profit: nil, date_sold: nil)
    #change selected items sold
    @sold_units = @remission.units.where(id: params[:unit_ids])
    #adds date of the unit sold
    @sold_units.each do |sold_unit|
      sold_unit.sold_data
    end
    #for the returned checkbox
    returned_units = @remission.units.where(id: params[:return_ids]).all
    @remission.add_devolutions(returned_units)
    redirect_to :back
  end

  def download
    @remission = Remission.find(params[:id])
    @units = @remission.units.order(:product_code)
    name_of_file="R-#{@remission.id.to_s}_#{@remission.store.name}_#{@remission.created_at.strftime("%H-%I-%G")}"
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=#{name_of_file}.xlsx"
      }
    end
  end

  def end
    @remission = Remission.find(params[:id])
    @units = @remission.units
    #separates sold and not sold units
    sold_units = @units.where(sold: true)
    not_sold_units = @units.where(sold: false)
    #desactivate remission and gets profit
    profit = sold_units.sum(:profit)
    @remission.update_attributes(active: false, profit: profit)
    #sends not sold units to storage,
    #saves info in devolutions and
    #takes them out of remission
    not_sold = @remission.units.where(sold: false)
    @remission.add_devolutions(not_sold)
    redirect_to @remission
  end

  def activate
    @remission = Remission.find(params[:id])
    @units = @remission.units
    #adds devolutions from storage to remission/store
    @remission.restore_devolutions
    @remission.update_attributes(active: true)
    redirect_to @remission
  end


  private

    def remission_params
      params.require(:remission).permit( :store_id,
                                         :price_modifier )
    end

    # Before filters
    def correct_brand
      @brand = current_brand
      @remission = Remission.find(params[:id])
      if @remission.units.any?
        @remission_brand = @remission.units.first.category.product.brand
        redirect_to(root_url) unless @brand == @remission_brand
      else
        return
      end
    end
end
