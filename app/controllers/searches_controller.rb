class SearchesController < ApplicationController
    before_action :authenticate_customer!

  def search
    @range = params[:range]
    if @range == "Restaurant"
        redirect_to search_result_path
        @restaurants = Restaurant.looks(params[:search], params[:word])
    else
        redirect_to search_result_path
        @Genres = Genre.looks(params[:search], params[:word])
    end
  end
  
  def search_result
    
  end
end
