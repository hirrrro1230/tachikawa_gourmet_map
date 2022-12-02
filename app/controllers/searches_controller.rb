class SearchesController < ApplicationController
    before_action :authenticate_customer!

  def search
    @range = params[:range]
    if @range == "Restaurant"
        
        @restaurants = Restaurant.looks(params[:search], params[:word])
        #redirect_to search_result_path
    else
        
        @Genres = Genre.looks(params[:search], params[:word])
        #redirect_to search_result_path
    end
  end
  
  def search_result
      
  end
end
