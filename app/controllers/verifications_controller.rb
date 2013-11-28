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
          @actum.libre=@log.libre
          @actum.pac=@log.pac
          @actum.ud=@log.ud
          @actum.dc=@log.dc
          @actum.alianza=@log.alianza
          @actum.pinu=@log.pinu
          @actum.blancos=@log.blancos
          @actum.nulos=@log.nulos
          @actum.is_sum_ok=@log.is_sum_ok
        end
        @actum.ready_for_review=true
        @actum.save
        
        format.html { redirect_to "/acta/random", notice: "Gracias! Tu chequeo del acta #{@actum.numero} ha sido ingresado. " }
        format.json { render json: @actum, status: :created, location: @actum }
      else
        @totalVotos=@actum.nacional.to_i+@actum.liberal.to_i+@actum.libre.to_i+@actum.ud.to_i+@actum.alianza.to_i+@actum.pinu.to_i+@actum.blancos.to_i+@actum.pac.to_i+@actum.nulos.to_i+@actum.dc.to_i

        @imageUrl = "http://s3-us-west-2.amazonaws.com/actashn/presidente/2/%05d.jpg" % @actum.numero
        @verification=@log

        @allow_verification = ((@actum.user_id != current_user.id) and (current_user.verifications.where(:acta_id=>@actum.id).count==0))
        
        @trigger_verification=true
        
        format.html { render "/acta/show"}
        format.json { render json: @actum.errors, status: :unprocessable_entity }
      end
    end
  end
end
