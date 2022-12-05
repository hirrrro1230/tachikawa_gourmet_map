class Public::SearchesController < ApplicationController
    before_action :authenticate_customer!
  
  def search_result
    @range = params[:range]
    if @range == "店舗"
        
        @restaurants = Restaurant.looks(params[:search], params[:word])
        #redirect_to search_result_path
    elsif @range == "ジャンル"
        @genre = Genre.find_by(name: params[:word])
        @restaurants = @genre.restaurants
        @genres = Genre.looks(params[:search], params[:word])
        #redirect_to search_result_path
    elsif @range == "住所"
        @address = Restaurant.find_by(address: params[:word])
        @restaurants = Restaurant.looks(params[:search], params[:word])
        
    else
        検索結果がありません
        
    end
  end
end
