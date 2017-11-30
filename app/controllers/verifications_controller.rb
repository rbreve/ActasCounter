class VerificationsController < ApplicationController
  def create
    @log = Verification.new(params[:verification])
    @log.user_id = current_user.id
    
    @actum=Actum.find(@log.acta_id)
    
    respond_to do |format|
      if @log.save
        if @log.is_valid
          @actum.verified_count+=1
        else
          @actum.verified_count=0
          @actum.liberal=@log.liberal
          @actum.nacional=@log.nacional
          @actum.libre_pinu=@log.libre_pinu
          @actum.pac=@log.pac
          @actum.ud=@log.ud
          @actum.dc=@log.dc
          @actum.alianza_patriotica=@log.alianza_patriotica
          @actum.vamos=@log.vamos
          @actum.frente_amplio=@log.frente_amplio
          @actum.blancos=@log.blancos
          @actum.nulos=@log.nulos
          @actum.is_sum_ok=@log.is_sum_ok
          @actum.image_changed=@log.image_changed
        end
        @actum.ready_for_review=true
        @actum.save
        
        if @actum.user_id==@log.user_id
          format.html { redirect_to actum_type_path(:type=>@actum.full_type,:id=>@actum.numero), notice: "Gracias! Tu chequeo del acta #{@actum.numero} ha sido ingresado. " }
        else
          format.html { redirect_to "/acta/random", notice: "Gracias! Tu chequeo del acta #{@actum.numero} ha sido ingresado. " }
        end
        
        format.json { render json: @actum, status: :created, location: @actum }
      else
        @totalVotos=@actum.nacional.to_i+@actum.liberal.to_i+@actum.libre_pinu.to_i+@actum.ud.to_i+@actum.alianza_patriotica.to_i+@actum.vamos.to_i+@actum.blancos.to_i+@actum.pac.to_i+@actum.nulos.to_i+@actum.dc.to_i+@actum.frente_amplio.to_i
        @totalActas=@actum.recibidas.to_i-@actum.sobrantes.to_i
        @totalVotosReportados=@actum.ciudadanos.to_i+@actum.miembros_mer.to_i

        @imageUrl = @actum.image
        @verification=@log

        @allow_verification = ((@actum.user_id != current_user.id) and (current_user.verifications.where(:acta_id=>@actum.id).count==0))
        
        @trigger_verification=true
        
        @report = Reporte.new
        @report.acta_id = @actum.id
        
        format.html { render "/acta/show"}
        format.json { render json: @actum.errors, status: :unprocessable_entity }
      end
    end
  end
end
