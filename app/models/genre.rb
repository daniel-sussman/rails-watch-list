class Genre < ApplicationRecord
  has_many :movies, through: :movie_genre
end
