class Public::SearchesController < ApplicationController
    before_action :authenticate_customer!
  
  def search_result
    @range = params[:range]
    if @range == "店舗"
        
        @restaurants = Restaurant.looks(params[:search], params[:word])
        #redirect_to search_result_path
    else
        
        @genres = Genre.looks(params[:search], params[:word])
        #redirect_to search_result_path
    end
  end
end
