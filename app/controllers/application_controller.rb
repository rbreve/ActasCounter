class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def verify_authentication
    unless user_signed_in?
      redirect_to root_path
    end
  end
  
  def verify_admin
    unless current_user.is_admin
      redirect_to root_path
    end
  end
end
