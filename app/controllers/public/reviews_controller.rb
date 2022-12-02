class Public::ReviewsController < ApplicationController
    before_action :authenticate_customer!, only: [:edit, :create, :destroy]
    def new
       @review = Review.new 
    end
    
    def create
        restaurant = Restaurant.find(params[:restaurant_id]) 
        @review = restaurant.reviews.new(review_params)
        @review.customer_id = current_customer.id
        if @review.save!
            redirect_to reviews_path
        end
    end
    
    def index
       @reviews = Review.all
    end
    
    def show
        @review = Review.find(params[:id])
        @comments = @review.comments  #投稿詳細に関連付けてあるコメントを全取得
        @comment = current_customer.comments.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
    end
    
    def edit
        @review = Review.find(params[:id])
    end
    
    def update
        @review = Review.find(params[:id])
        if @review.update(review_params)
            redirect_to customers_my_page_reviews_path, notic: 'レビューを更新しました。'
        else
            flash.now[:alert] = '情報を入力してください'
            render :edit
        end
    end
    
    def destroy
        @review = Review.find(params[:id])
        @review.destroy
        redirect_to customers_my_page_reviews_path, notice: 'レビューを削除しました。'
    end
    
    def review_params
        params.require(:review).permit(:overall, :coment)
    end
    
end
