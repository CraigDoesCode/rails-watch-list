# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'
require 'json'

url = "https://tmdb.lewagon.com/movie/top_rated"

movies = JSON.parse(URI.open(url).read)
Movie.destroy_all
List.destroy_all
movies['results'].each do |movie|
  Movie.create!(title: movie['original_title'],
                overview: movie['overview'],
                poster_url: "https://image.tmdb.org/t/p#{movie['poster_path']}",
                rating: movie['vote_average'].to_f)
end

List.create!(name: 'horror')
List.create!(name: 'comedy')
List.create!(name: 'romantic')
List.create!(name: 'thriller')
