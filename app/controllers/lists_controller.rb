class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.image_url = random_url
    if @list.save
      redirect_to lists_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end

  def random_url
    %w[action_genre.jpg adventure_genre.jpg animation_genre.jpeg comedy_genre.png crime_genre.jpg documentary_genre.jpeg drama_genre.png family_genre.png fantasy_genre.jpg history_genre.jpg horror_genre.jpg music_genre.jpeg mystery_genre.png romance_genre.jpg sci-fi_genre.jpg thriller_genre.png TV-movie_genre.jpg war_genre.jpg western_genre.jpg].sample
  end
end
