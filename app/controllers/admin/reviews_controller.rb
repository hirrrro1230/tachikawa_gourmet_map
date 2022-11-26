class Admin::ReviewsController < ApplicationController
    def new
        @review = Review.new
    end
    
    def index
        @reviews = Review.all
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
        redirect_to reviews_path, notice: 'レビューを削除しました。'
    end
    
    def review_params
        params.require(:review).permit(:overall, :coment)
    end
        
end
