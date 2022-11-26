class Admin::GenresController < ApplicationController
    
    
    def index
        @genres = Genre.all
    end
    
    def new
        @genre = Genre.new
    end
    
    def create
        @genre = Genre.new(genre_params)
        if @genre.save
            redirect_to '/admin/genres'
            flash[:notice] = "ジャンルを追加しました。"
        else
            flash[:notice] = "ジャンル名を追加してください。"
            @genres = Genre.all
            render :index
        end
    end
    
    def edit
        @genre = Genre.find(params[:id])
    end
    
    def update
        genre = Genre.find(params[:id])
        genre.update(genre_params)
        redirect_to admin_genres_path
    end
    
    def destroy
        @genre = Genre.find(params[:id])
        @genre.destroy
        redirect_to admin_genres_path
    end
    
    private
    
    def genre_params
        params.require(:genre).permit(:name)
    end
    
end
