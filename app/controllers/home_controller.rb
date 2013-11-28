class HomeController < ApplicationController
  def index
    #if user_signed_in?
    #  redirect_to acta_path
    #end
    @results = Actum.results
  end
end
