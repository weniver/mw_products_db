class UnitsController < ApplicationController
  before_action :check_and_create_color, only: :create

  def index
    @units = Unit.all
  end

  def new
    @unit = Unit.new
    @products = current_brand.products
  end

  def create
    @unit = Unit.new(unit_params)
    @products = current_brand.products
    if @unit.valid?
      @unit.quantity.to_i.times do
        copy = @unit.dup
        copy.save
      end
      flash[:info] = "Se generaron #{@unit.quantity} unidades de #{@unit.category.name} a #{@unit.category.product.name}."
      redirect_to category_url(@unit.category)
    else
      render 'new'
    end
  end

  def destroy
    Unit.find(params[:id]).destroy
    flash[:success] = "Producto Eliminado"
    redirect_to :back
  end

  def edit
    @unit = Unit.find(params[:id])
    @products = current_brand.products
  end

  def update
    @unit = Unit.find(params[:id])
    @products = current_brand.products
    if @unit.update_attributes(unit_params)
      flash[:success] = 'Producto Editado'
      redirect_to :back
    else
      render 'edit'
    end
  end

  private

    def unit_params
      params.require(:unit).permit(:quantity,
                                   :product_id,
                                   :category_id,
                                   :pattern_id,
                                   :fabric_id,
                                   :color_id,
                                   :batch_id,
                                    colors:
                                  [:hue, :tone, :darkness])
    end

    def check_and_create_color
      hue = params[:unit][:colors][:hue]
      tone = params[:unit][:colors][:tone]
      darkness = params[:unit][:colors][:darkness]
      color = Color.new(hue: hue,
                          tone: tone,
                          darkness: darkness)
      #if the color is valid it already exists in Colors so it gives the color_id to the unit
      unless color.valid?
        color_in_record = Color.find_by(real_color: color.real_color)
        color_id = color_in_record.id
        params[:unit][:color_id] = color_id
      #if is a new color it saves and it passes the color_id to the unit
      else
        color.save
        params[:unit][:color_id] = color.id
      end
    end
end
