require 'open-uri'
class ActaController < ApplicationController
  before_filter :verify_authentication
  
  # GET /acta
  # GET /acta.json
  def index
    @acta = Actum.all

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
           
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @acta }
    end
    
  end

  # GET /acta/1
  # GET /acta/1.json
  def show
    if(params[:id]=="random")
      @actum= Actum.order("RANDOM()").first
    else
      @actum = Actum.find(params[:id])
    end
    
    @totalVotos=@actum.nacional.to_i+@actum.liberal.to_i+@actum.libre.to_i+@actum.ud.to_i+@actum.alianza.to_i+@actum.pinu.to_i+@actum.blancos.to_i+@actum.pac.to_i+@actum.nulos.to_i+@actum.dc.to_i
    
    @imageUrl = "http://s3-us-west-2.amazonaws.com/actashn/presidente/1/%05d.jpg" % @actum.numero

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @actum }
    end
 
  end

  # GET /acta/new
  # GET /acta/new.json
  def new
    @invalid=true
    begin
      i = Actum.order("numero ASC").last.numero.to_i
    rescue
      i = 1
    end
    
    while(@invalid)
      i+=1    
      @imageUrl = "http://s3-us-west-2.amazonaws.com/actashn/presidente/1/%05d.jpg" % i
      begin
        open(@imageUrl)
      rescue OpenURI::HTTPError  
        print "invalid"
      else
        print "valid"
        @invalid=false
      end
    end
    
    @actum = Actum.new
    @actum.liberal=@actum.nacional=@actum.libre=@actum.pac=@actum.ud=@actum.dc=@actum.alianza=@actum.pinu=@actum.blancos=@actum.nulos=0
    @actum.numero=i

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @actum }
    end
  end

  # GET /acta/1/edit
  def edit
    @actum = Actum.find(params[:id])
    @imageUrl = "http://s3-us-west-2.amazonaws.com/actashn/presidente/1/%05d.jpg" % @actum.numero
  end

  # POST /acta
  # POST /acta.json
  def create
    @actum = Actum.new(params[:actum])
    @actum.user_id = current_user.id
        
    respond_to do |format|
      if @actum.save
        format.html { redirect_to @actum, notice: 'El Acta fue ingresada al sistema.' }
        format.json { render json: @actum, status: :created, location: @actum }
      else
        format.html { render action: "new" }
        format.json { render json: @actum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /acta/1
  # PUT /acta/1.json
  def update
    @actum = Actum.find(params[:id])

    respond_to do |format|
      if @actum.update_attributes(params[:actum])
        format.html { redirect_to @actum, notice: 'Actum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @actum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acta/1
  # DELETE /acta/1.json
  def destroy
    @actum = Actum.find(params[:id])
    @actum.destroy

    respond_to do |format|
      format.html { redirect_to acta_url }
      format.json { head :no_content }
    end
  end
end
