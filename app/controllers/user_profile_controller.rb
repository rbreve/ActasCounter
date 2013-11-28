class UserProfileController < ApplicationController

  def index
    @users = User.order("acta_count DESC").limit(10)
  end

  def show
    @user = User.find(params[:id])

   
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
end
