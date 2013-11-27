class VerificationsController < ApplicationController
  def create
    @log = Verification.new(params[:verification])
    @log.user_id = current_user.id
    
    respond_to do |format|
      if @log.save
        
        @actum=Actum.find(@log.acta_id)
        if @log.is_valid
          @actum.verified_count+=1
        else
          @actum.verified_count=0
          @actum.liberal=@log.liberal
          @actum.nacional=@log.nacional
          @actum.libre=@log.libre
          @actum.pac=@log.pac
          @actum.ud=@log.ud
          @actum.dc=@log.dc
          @actum.alianza=@log.alianza
          @actum.pinu=@log.pinu
        end
        @actum.save
        
        format.html { redirect_to acta_path, notice: "Gracias! Tu chequeo del acta #{@actum.numero} ha sido ingresado." }
        format.json { render json: @actum, status: :created, location: @actum }
      else
        format.html { render action: "new" }
        format.json { render json: @actum.errors, status: :unprocessable_entity }
      end
    end
  end
end
