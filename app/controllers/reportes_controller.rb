class ReportesController < ApplicationController
  def index
    @reportes = Reporte.order("created_at DESC").page(params[:page]).per_page(25)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reportes }
    end
  end

  def create
    @reporte = Reporte.new(params[:reporte])
    @reporte.user_id=current_user.id
    @reporte.date = DateTime.now
    
    respond_to do |format|
      if @reporte.save
        format.html { redirect_to  @reporte.actum, notice: 'Gracias, su reporte fue creado' }
        format.json { render json: @reporte, status: :created, location: @reporte }
      else
        format.html { render action: "new" }
        format.json { render json: @reporte.errors, status: :unprocessable_entity }
      end
    end
  end

end
