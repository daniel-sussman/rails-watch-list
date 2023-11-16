class AddGenreIdToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :genre_id, :integer
  end
end
