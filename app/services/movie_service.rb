# frozen_string_literal: true

class MovieService
  def self.top_rated
    response = conn.get('/3/movie/top_rated')
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.movie_data(movie_id)
    json = JSON.parse(conn.get("/3/movie/#{movie_id}").body, symbolize_names: true)
  end

  def self.search(query)
    pages = [1, 2]
    response = pages.map do |page|
      conn.get("/3/search/movie?page=#{page}&query={#{query}}")
    end
    data = response.map do |r|
      JSON.parse(r.body, symbolize_names: true)
    end
    data.flat_map do |d|
      d[:results]
    end
  end

  def self.credits(movie_id)
    json = JSON.parse(conn.get("/3/movie/#{movie_id}/credits").body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.themoviedb.org') do |f|
      f.params['api_key'] = ENV['api_key']
    end
  end
end
