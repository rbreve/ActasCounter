require 'open-uri'
class ActaController < ApplicationController
  before_filter :verify_authentication
  
  # GET /acta
  # GET /acta.json
  def index
    @acta = Actum.where(:ready_for_review=>true).order("created_at ASC").page(params[:page]).per_page(25)

    @sumLiberal = Actum.sum('liberal')
    @sumLibre = Actum.sum('libre')
    @sumNacional = Actum.sum('nacional')
    @sumPac = Actum.sum('pac')
    @sumUD = Actum.sum('ud')
    @sumDC = Actum.sum('dc')
    @sumAlianza = Actum.sum('alianza')
    @sumPinu = Actum.sum('pinu')
    @sumBlancos = Actum.sum('blancos')
    @sumNulos = Actum.sum('nulos')
    @sumVerified = Actum.sum('verified_count')
    
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
    if(params[:id]=="random")
      @actum= Actum.where(["user_id<>? AND ready_for_review=? AND id NOT IN (?) and verified_count<?",current_user.id,true,current_user.verifications.map{ |x| x.acta_id },VERIFICATIONS]).order("RANDOM()").first
    else
      @actum = Actum.find(params[:id])
    end
    
    if @actum.nil?
      redirect_to acta_path, :notice=> "No hay actas pendientes de verificacion ingresadas por otros usuarios..."
      return
    end
    @totalVotos=@actum.nacional.to_i+@actum.liberal.to_i+@actum.libre.to_i+@actum.ud.to_i+@actum.alianza.to_i+@actum.pinu.to_i+@actum.blancos.to_i+@actum.pac.to_i+@actum.nulos.to_i+@actum.dc.to_i
    
    @imageUrl = "http://s3-us-west-2.amazonaws.com/actashn/presidente/3/%05d.jpg" % @actum.numero
    
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
      @actum.save
      @next_available.update_attribute(:already_assigned,true) if @next_available
      
      redirect_to @actum
      return
    end
  end


  def new_old_version
    @pending_actas = Actum.where(:ready_for_review=>false,:user_id=>current_user.id)
    if @pending_actas.length>0
      @actum=@pending_actas.first
    else
       @invalid=true
       @numero=0
       
       while(@invalid)
        begin
          @next_available = AvailableNumber.where(:has_valid_image=>true, :already_assigned=>false).order("RANDOM()").reload.first
        rescue
          @next_available = nil
        end
        #--- we use .reload to force the query to run again and not from sql cache...
        
        if @next_available
          i = @next_available.numero.to_i
        else
          i = Random.rand(15000)
        end

        @imageUrl = "http://s3-us-west-2.amazonaws.com/actashn/presidente/3/%05d.jpg" % i
 
        begin
          open(@imageUrl)
        rescue OpenURI::HTTPError  
           print "invalid "
           @next_available.update_attribute(:has_valid_image,false) if @next_available
        else
           print "valid"  
           if(!Actum.exists?(numero: i.to_s))
             @invalid=false
           end
        end
        @numero=i
      end
    
      @actum = Actum.new
      @actum.numero=@numero
      @actum.liberal=@actum.nacional=@actum.libre=@actum.pac=@actum.ud=@actum.dc=@actum.alianza=@actum.pinu=@actum.blancos=@actum.nulos=0
      @actum.user_id=current_user.id
      @actum.ready_for_review=false
      @actum.save
     
      @next_available.update_attribute(:already_assigned,true) if @next_available
    end
    redirect_to @actum
  end
  
  # GET /acta/1/edit
  # def edit
  #   @actum = Actum.find(params[:id])
  #   @imageUrl = "http://s3-us-west-2.amazonaws.com/actashn/presidente/1/%05d.jpg" % @actum.numero
  # end

  # POST /acta
  # POST /acta.json
  def create
    if @actum=Actum.find_by_numero(params[:actum][:numero])
      redirect_to @actum, notice: 'Alguien ingreso esta acta antes. Puedes verificarla...'
    else
      @actum = Actum.new(params[:actum])
      @actum.user_id = current_user.id
        
      respond_to do |format|
        if @actum.save
          format.html { redirect_to acta_path, notice: 'El Acta fue ingresada al sistema.' }
          format.json { render json: @actum, status: :created, location: @actum }
        else
          i=@actum.numero.to_i
          @imageUrl = "http://s3-us-west-2.amazonaws.com/actashn/presidente/3/%05d.jpg" % i
          
          format.html { render action: "new" }
          format.json { render json: @actum.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PUT /acta/1
  # PUT /acta/1.json
  # def update
  #   @actum = Actum.find(params[:id])
  #   respond_to do |format|
  #     if @actum.update_attributes(params[:actum])        
  #       format.html { redirect_to @actum, notice: 'Actum was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: "edit" }
  #       format.json { render json: @actum.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  
  # DELETE /acta/1
  # DELETE /acta/1.json
  # def destroy
  #   @actum = Actum.find(params[:id])
  #   @actum.destroy
  #   respond_to do |format|
  #     format.html { redirect_to acta_url }
  #     format.json { head :no_content }
  #   end
  # end
end
