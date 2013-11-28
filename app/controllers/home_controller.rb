class HomeController < ApplicationController
  def index
    @results = Actum.results
  end
end
