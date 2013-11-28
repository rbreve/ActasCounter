class HomeController < ApplicationController
  def index
    @results = Actum.results
  end
  
  def all_done
  end
end
