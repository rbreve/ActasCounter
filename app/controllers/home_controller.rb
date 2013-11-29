class HomeController < ApplicationController
  def index
    @results = Rails.cache.fetch("main-results", :expires_in=>1.minute) {Actum.results}
  end
  
  def all_done
  end
end
