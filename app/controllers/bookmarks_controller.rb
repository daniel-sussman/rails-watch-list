class BookmarksController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      genre_id = find_most_common_genre(@list)
      @list.image_url = Genre.find(genre_id).image_url
      @list.save
      redirect_to @list
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    genre_id = find_most_common_genre(bookmark.list)
      bookmark.list.image_url = Genre.find(genre_id).image_url
      bookmark.list.save
    redirect_to bookmark.list
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end

  def find_most_common_genre(list)
    list_genres = Hash.new(0)
    list.movies.each do |movie|
      MovieGenre
        .where("movie_id = '#{movie.id}'")
        .each { |entry| list_genres[entry.genre_id] += 1 }
    end
    list_genres.max_by { |_genre, count| count }[0]
  end
end
