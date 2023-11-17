class Movie < ApplicationRecord
  has_many :bookmarks
  has_many :genres, through: :movie_genre
  has_many :lists, through: :bookmarks

  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
end
