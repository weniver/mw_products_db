class BatchesController < ApplicationController
  def destroy
    batch = Batch.find(params[:id])
    flash[:success] = "Las #{batch.units.count} piezas de #{batch.units.first.category.product.name}: #{batch.units.first.category.name} del Lote creado el #{batch.units.first.created_at.strftime('%v')} han sido eliminadas."
    batch.destroy
    redirect_to batches_url
  end

  def index
    @batches = Batch.all
  end
end
