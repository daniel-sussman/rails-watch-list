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
    list = List.new(list_params)
    list.image_url = random_url
    list.save
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end

  def random_url
    %w[action_genre adventure_genre animation_genre comedy_genre crime_genre documentary_genre drama_genre family_genre fantasy_genre history_genre horror_genre music_genre mystery_genre romance_genre sci-fi_genre thriller_genre TV-movie_genre war_genre western_genre].sample
  end
end
