require 'open-uri'
class ActaController < ApplicationController
  before_filter :verify_authentication
  
  # GET /acta
  # GET /acta.json
  def index
    @actum_short_type= Actum.short_type(params[:type])
    @actum_short_type= "p" if @actum_short_type.nil?
      
    exp_sums=90
    
    @acta = Rails.cache.fetch("actum-page-#{params[:page]}-#{@actum_short_type}", :expires_in=>exp_sums.seconds) {
      Actum.where(:ready_for_review=>true,:actum_type=>@actum_short_type).order("created_at ASC").page(params[:page]).per_page(25)
      }

    @sumLiberal = Rails.cache.fetch("sum-liberal-#{@actum_short_type}", :expires_in=>exp_sums.seconds){
      Actum.where(:actum_type =>@actum_short_type).sum('liberal')
      }
      
    @sumLibre = Rails.cache.fetch("sum-libre-#{@actum_short_type}", :expires_in=>exp_sums.seconds){
      Actum.where(:actum_type =>@actum_short_type).sum('libre')
      }
      
    @sumNacional = Rails.cache.fetch("sum-nacional-#{@actum_short_type}", :expires_in=>exp_sums.seconds){
      Actum.where(:actum_type =>@actum_short_type).sum('nacional')
      }
      
    @sumPac = Rails.cache.fetch("sum-pac-#{@actum_short_type}", :expires_in=>exp_sums.seconds){
      Actum.where(:actum_type =>@actum_short_type).sum('pac')
      }
      
    @sumUD = Rails.cache.fetch("sum-ud-#{@actum_short_type}", :expires_in=>exp_sums.seconds){
      Actum.where(:actum_type =>@actum_short_type).sum('ud')
      }
      
    @sumDC = Rails.cache.fetch("sum-dc-#{@actum_short_type}", :expires_in=>exp_sums.seconds){
      Actum.where(:actum_type =>@actum_short_type).sum('dc')
      }
      
    @sumAlianza = Rails.cache.fetch("sum-alianza-#{@actum_short_type}", :expires_in=>exp_sums.seconds){
      Actum.where(:actum_type =>@actum_short_type).sum('alianza')
      }
      
    @sumPinu = Rails.cache.fetch("sum-pinu-#{@actum_short_type}", :expires_in=>exp_sums.seconds){
      Actum.where(:actum_type =>@actum_short_type).sum('pinu')
      }
      
    @sumBlancos = Rails.cache.fetch("sum-blancos-#{@actum_short_type}", :expires_in=>exp_sums.seconds){
      Actum.where(:actum_type =>@actum_short_type).sum('blancos')
      }
      
    @sumNulos = Rails.cache.fetch("sum-nulos-#{@actum_short_type}", :expires_in=>exp_sums.seconds){
      Actum.where(:actum_type =>@actum_short_type).sum('nulos')
      }
      
    @sumVerified = Rails.cache.fetch("sum-verified-#{@actum_short_type}", :expires_in=>exp_sums.seconds){
      Actum.where(:actum_type =>@actum_short_type).sum('verified_count')
      }
    
    @sumAll=@sumLiberal+@sumLibre+@sumNacional+@sumPac+@sumUD+@sumDC+@sumAlianza+@sumPinu+@sumBlancos+@sumNulos
    
    @pending_actas = Actum.where(:ready_for_review=>false,:user_id=>current_user.id)
           
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @acta }
    end
    
  end

  # GET /acta/1
  # GET /acta/1.json
  def show
    @actum_short_type= begin Actum.short_type(params[:type]) rescue "p" end
    @actum_short_type= "p" if @actum_short_type.nil?
    
    if(params[:numero])
       @actum= Actum.find_by_numero_and_actum_type(params[:numero].to_s, @actum_short_type)
       notice_msg="Acta no encontrada..."
    elsif(params[:id]=="random")
      if current_user.verifications.length>0
        @actum= Actum.where(["user_id<>? AND ready_for_review=? AND id NOT IN (?) and verified_count<?",current_user.id,true,current_user.verifications.map{ |x| x.acta_id },VERIFICATIONS]).order("RANDOM()").first
      else
        @actum= Actum.where(["user_id<>? AND ready_for_review=? AND verified_count<?",current_user.id,true,VERIFICATIONS]).order("RANDOM()").first
      end
      notice_msg="No hay actas pendientes de verificacion ingresadas por otros usuarios..."
    else
      @actum = Actum.find_by_numero_and_actum_type(params[:id].to_s, @actum_short_type)
      notice_msg="Acta no encontrada..."
    end
    
    if @actum.nil?
      redirect_to acta_path, :notice=>notice_msg
      return
    end
    @totalVotos=@actum.nacional.to_i+@actum.liberal.to_i+@actum.libre.to_i+@actum.ud.to_i+@actum.alianza.to_i+@actum.pinu.to_i+@actum.blancos.to_i+@actum.pac.to_i+@actum.nulos.to_i+@actum.dc.to_i
    
    @imageUrl = @actum.image
    
    @verification=Verification.new
    @verification.is_valid=true
    @verification.liberal=@actum.liberal
    @verification.nacional=@actum.nacional
    @verification.libre=@actum.libre
    @verification.pac=@actum.pac
    @verification.ud=@actum.ud
    @verification.dc=@actum.dc
    @verification.alianza=@actum.alianza
    @verification.pinu=@actum.pinu
    @verification.blancos=@actum.blancos
    @verification.nulos=@actum.nulos
    @verification.is_sum_ok=@actum.is_sum_ok
    @verification.acta_id=@actum.id

    @allow_verification = ((@actum.user_id != current_user.id) and (current_user.verifications.where(:acta_id=>@actum.id).count==0))
    
    if @actum.verifications.count==0 and @actum.user_id==current_user.id
      @trigger_verification=true
    end
    
    @report = Reporte.new
    @report.acta_id = @actum.id
   
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @actum }
    end
 
  end

  def new
    begin
      @next_available = AvailableNumber.where(:has_valid_image=>true, :already_assigned=>false).order("RANDOM()").reload.first
    rescue
      @next_available = nil
    end
    
    if @next_available.nil?
       redirect_to all_done_path
       return
    else
      @numero = @next_available.numero.to_i
      @actum = Actum.new
      @actum.numero=@numero
      @actum.liberal=@actum.nacional=@actum.libre=@actum.pac=@actum.ud=@actum.dc=@actum.alianza=@actum.pinu=@actum.blancos=@actum.nulos=0
      @actum.user_id=current_user.id
      @actum.ready_for_review=false
      @actum.actum_type=@next_available.actum_type
      @actum.municipio_id=@actum.get_municipio_id if @actum.actum_type=="a"
      @actum.save
      @next_available.update_attribute(:already_assigned,true) if @next_available
      
      redirect_to @actum
      return
    end
  end
end
