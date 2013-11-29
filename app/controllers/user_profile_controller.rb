class UserProfileController < ApplicationController
  def index
    @users = Rails.cache.fetch("top-creators", :expires_in=>5.minutes) {User.order("acta_count DESC").limit(50)}
    @usersV = Rails.cache.fetch("top-verificators", :expires_in=>5.minutes) {User.order("verifications_count DESC").limit(50)}
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
end
