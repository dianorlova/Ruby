# frozen_string_literal: true

# The class describes the movie
class Movie
  include Comparable

  attr_reader :title, :kinopoisk, :imdb, :metacritic, :rotten_tomatoes

  def initialize(row_arg)
    @title = row_arg['title']
    @kinopoisk = row_arg['kinopoisk'].to_f
    @imdb = row_arg['imdb'].to_f
    @metacritic = row_arg['metacritic'].to_f
    @rotten_tomatoes = row_arg['rotten_tomatoes'].to_f
  end

  # вирт. атрибут (грубо говоря метод, который высчитывает что-то через уже имеющиеся поля класса)
  def ogon_rating
    ((@imdb + @kinopoisk + (@metacritic + @rotten_tomatoes) / 2) / 3)
  end

  def <=>(other)
    ogon_rating <=> other.ogon_rating
  end

  def to_hash
    { 'title' => @title, 'kinopoisk' => @kinopoisk, 'imdb' => @imdb,
      'metacritic' => @metacritic, 'rotten_tomatoes' => @rotten_tomatoes,
      'ogon_rating' => ogon_rating }
  end

  def to_s
    "Movie #{@title}\nRating\n" \
    "Kinopoisk: #{format('%.1f', @kinopoisk)}\n" \
    "Imdb: #{format('%.1f', @imdb)}\n" \
    "Metacritic: #{format('%.1f', @metacritic)}\n" \
    "Rotten tomatoes: #{format('%.1f', @rotten_tomatoes)}\n" \
    "Ogon rating: #{format('%.1f', ogon_rating)}"
  end
end
