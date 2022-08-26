# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MovieFacade' do
  describe 'top_20_rated' do
    it 'retieves the top 20 movies from the API', :vcr do
      movies = MovieFacade.top_20_rated

      expect(movies).to be_a Array
      expect(movies).to be_all Movie
    end
  end

  describe 'search' do
    it 'searches for movies by the keyword from the API', :vcr do
      query = 'something'
      movies = MovieFacade.search(query)
      expect(movies).to be_a Array
      expect(movies).to be_all Movie
    end
  end

  it 'retrieves a single movie', :vcr do
    movie = MovieFacade.movie_details(49_022)

    expect(movie).to be_a Movie
  end
end
