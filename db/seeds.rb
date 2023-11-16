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

puts "Destroying existing movies database"

Movie.destroy_all

puts "Seeding database with new movies..."

url = 'https://tmdb.lewagon.com/movie/top_rated'
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)["results"]

poster_url = "https://image.tmdb.org/t/p/w500"

movies.each do |movie|
  Movie.create!(title: movie["title"], overview: movie["overview"], poster_url: "#{poster_url}#{movie["poster_path"]}", rating: movie["vote_average"].round(1), genre_id: movie["genre_ids"][0])
end

puts "Finished seeding with new movies!"
