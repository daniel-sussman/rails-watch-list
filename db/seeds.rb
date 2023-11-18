# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "json"
require "open-uri"

puts "Destroying existing genre database"

Genre.destroy_all

puts "Building list of movie genres..."

genres = {
  '28' => "action_genre.jpg",
  '12' => "adventure_genre.jpg",
  '16' => "animation_genre.jpeg",
  '35' => "comedy_genre.png",
  '80' => "crime_genre.jpg",
  '99' => "documentary_genre.jpeg",
  '18' => "drama_genre.png",
  '10751' => "family_genre.png",
  '14' => "fantasy_genre.jpg",
  '36' => "history_genre.jpg",
  '27' => "horror_genre.jpg",
  '10402' => "music_genre.jpeg",
  '9648' => "mystery_genre.png",
  '10749' => "romance_genre.jpg",
  '878' => "sci-fi_genre.jpg",
  '10770' => "thriller_genre.png",
  '53' => "TV-movie_genre.jpg",
  '10752' => "war_genre.jpg",
  '37' => "western_genre.jpg"
}

genres.each do |genre|
  Genre.create(id: genre[0], image_url: genre[1])
end

puts "Genre list complete."

puts "Destroying existing movies database"

Movie.destroy_all

puts "Seeding database with new movies..."

url = 'https://tmdb.lewagon.com/movie/top_rated'
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)["results"]

poster_url = "https://image.tmdb.org/t/p/w500"

movies.each do |movie|
  new_movie = Movie.create(title: movie["title"], overview: movie["overview"], poster_url: "#{poster_url}#{movie["poster_path"]}", rating: movie["vote_average"].round(1))
  movie["genre_ids"].each do |genre_id|
    MovieGenre.create(movie_id: new_movie.id, genre_id: genre_id)
  end
end

puts "Finished seeding with new movies!"
