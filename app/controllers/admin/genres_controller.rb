class Admin::GenresController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @genre = Genre.all
  end

  def new
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      render :new
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    if genre.destroy
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :is_enable)
  end

end
