class Public::FavoritesController < ApplicationController
    def create
        @restaurant = Restaurant.find(params[:restaurant_id])
        favorite = current_customer.favorites.new(restaurant_id: @restaurant.id)
        favorite.save
        #非同期処理を実装
        #redirect_to restaurant_path(restaurant), notice: "いいねしました！"
    end

    def destroy
        @restaurant = Restaurant.find(params[:restaurant_id])
        favorite = current_customer.favorites.find_by(restaurant_id: @restaurant.id)
        favorite.destroy
        #非同期処理を実装
        #redirect_to restaurant_path(restaurant), alert: "いいねを取り消しました"
    end
end
