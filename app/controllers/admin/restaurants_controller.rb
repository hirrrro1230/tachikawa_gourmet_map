class Admin::RestaurantsController < ApplicationController
    
    def new
        @restaurant = Restaurant.new
    end
    
    def create
        @restaurant = Restaurant.new(restaurant_params)
        @restaurant.customer_id = current_admin.id
        if @restaurant.save
            redirect_to admin_restaurant_path(@restaurant.id)
        else
            render :new
        end
    end
    
    def index
        @restaurants = Restaurant.all
    end
    
    def show
        @restaurant = Restaurant.find(params[:id])
    end
    
    def edit
        @restaurant = Restaurant.find(params[:id])
    end
    
    def update
        @restaurant = Restaurant.find(params[:id])
        if @restaurant.update!(restaurant_params)
            redirect_to admin_restaurant_path(@restaurant.id), notice: '店舗情報を更新しました。'
        else
            flash.now[:alert] = '情報を入力してください。'
            render :edit
        end
    end
    
    def destroy
        @restaurant = Restaurant.find(params[:id])
        @restaurant.destroy
        redirect_to admin_restaurants_path, notice: 'レビューを削除しました。'
    end
    
    private
    
    def restaurant_params
        params.require(:restaurant).permit(:image, :name, :address, :genre_id, :opening_hour)
    end
end
