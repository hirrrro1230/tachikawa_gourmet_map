class Public::RestaurantsController < ApplicationController
    
    def new
        @customer = current_customer
        @restaurant = Restaurant.new
    end
    
    def create
        @restaurant = Restaurant.new(restaurant_params)
        @restaurant.customer_id = current_customer.id
        if @restaurant.save
            redirect_to restaurant_path(@restaurant.id),notice: "店舗を新規登録しました。"
        else
            render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
        end
    end
    
    def show
        @restaurant = Restaurant.find(params[:id])
        @review = Review.new
        @reviews = @restaurant.reviews
    end
    
    def edit
        @restaurant = Restaurant.find(params[:id])
    end
    
    def update
        @restaurant = Restaurant.find(params[:id])
        if @restaurant.update(restaurant_params)
            redirect_to restaurant_path(@restaurant.id)
        else
            flash.now[:alert] = '情報を入力してください。'
            render :edit
        end
    end
    
    def destroy
        @restaurant = Restaurant.find(params[:id])
        @restaurant.destroy
        redirect_to restaurants_path, notice: '店舗を削除しました'
    end
            
    
    def index
        @restaurants = Restaurant.all
    end
    
    def top
        @restaurants = Restaurant.all
        
    end
    
    def restaurant_params
        params.require(:restaurant).permit(:image, :name, :address, :genre_id, :opening_hour, :customer_id, :overall, :is_draft)
    end
end
