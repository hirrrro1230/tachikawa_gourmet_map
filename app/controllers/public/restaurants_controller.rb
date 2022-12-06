class Public::RestaurantsController < ApplicationController
    
    def new
        @customer = current_customer
        @restaurant = Restaurant.new
    end
    
    def create
        @customer = current_customer
        customer_id = current_customer.id
        @restaurant = Restaurant.create(restaurant_params)
        if params[:post]
            if @restaurant.save
                redirect_to restaurant_path(@restaurant.id)
            else
                render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
            end
        else
          if @restaurant.update(is_draft: true)
            redirect_to customer_path(current_customer), notice: "投稿を下書き保存しました"
          else
            render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
          end
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
        if @restaurant.update!(restaurant_params)
            redirect_to restaurant_path(@restaurant.id), notice: '店舗情報を更新しました。'
        else
            flash.now[:alert] = '情報を入力してください。'
            render :edit
        end
    end
            
    
    def index
        @restaurants = Restaurant.all
    end
    
    def top
        @restaurants = Restaurant.all
        
    end
    
    def restaurant_params
        params.require(:restaurant).permit(:image, :name, :address, :genre_id, :opening_hour, :customer_id, :overall)
    end
end
