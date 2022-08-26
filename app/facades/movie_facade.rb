# frozen_string_literal: true

class MovieFacade
  def self.movie_details(movie_id)
    parsed_json = MovieService.movie_data(movie_id)
    Movie.new(parsed_json)
  end

  def self.top_20_rated
    parsed_json = MovieService.top_rated
    parsed_json[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def self.search(query)
    results = MovieService.search(query)
    results.map do |movie_data|
      Movie.new(movie_data)
    end
  end

  def self.cast(movie_id)
    data = MovieService.credits(movie_id)
    Movie.new(data)
  end
end
