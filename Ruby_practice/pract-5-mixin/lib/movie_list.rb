# frozen_string_literal: true

require 'csv'

require_relative 'movie'
class ClassName
  include Enumerable

  attr_reader :movies

  def initialize
    @movies = []
  end

  def read_data(_path_file)
    csv = CSV.read(path, headers: true, col_sep: ',')
    csv.each do |row|
      movie = Movie.new(row)
      @movies.append(movie)
    end
  end

  def save_sorted_list(_path_file)
    headers = %w[title kinopoisk imdb metacritic rotten_tomatoes ogon_rating]
    sort_movies = @movies.sort.reverse
    CSV.open(path, 'w', col_sep: ',') do |csv|
      csv << headers
      sort_movies.each do |movie|
        csvfile << movie.to_hash.values
      end
    end
    csv.close
  end

  # итератор должен вызывать ассоциированный блок для каждого элемента массива @movies
  def each(&block)
    @movies.each(&block)
  end

  def average_ogon_rating
    sum_ogon_rating = reduce(0) do |memo, movie|
      memo + movie.ogon_rating
    end
    sum_ogon_rating / count
  end
end
