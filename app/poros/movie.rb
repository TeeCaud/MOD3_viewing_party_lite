# frozen_string_literal: true

class Movie
  attr_reader :id,
              :title,
              :vote_average,
              :runtime,
              :summary,
              :vote_count,
              :genres,
              :runtime,
              :cast

  def initialize(data)
    @id = data[:id]
    @title = data[:title]
    @vote_average = data[:vote_average]
    @runtime = data[:runtime]
    @summary = data[:overview]
    @vote_count = data[:vote_count]
    @genres = data[:genres]
    @runtime = data[:runtime]
    @cast = data[:cast]
  end

  def genre_name
    genre = @genres.flat_map { |g| g[:name] }
  end

  def cast_name
    cast = @cast.map { |c| c[:name] }
  end
end
