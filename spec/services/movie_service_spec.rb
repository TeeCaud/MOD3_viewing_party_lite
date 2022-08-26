# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MovieService' do
  it 'retrieves movie data and parses response', :vcr do
    parsed_json = MovieService.top_rated

    expect(parsed_json).to be_a Hash
    expect(parsed_json[:results]).to be_a Array

    movie = parsed_json[:results].first

    expect(movie).to include :id, :title, :vote_average
    expect(movie[:title]).to be_a String
  end

  it 'searches for movies by user input and returns array of movies', :vcr do
    query = 'something'
    search = MovieService.search(query)
    movie = search.first

    expect(search).to be_a Array
    expect(movie).to be_a Hash
    expect(movie).to include :id, :title, :vote_average
    expect(movie[:title]).to be_a String
  end

  it 'can search for an individual movie', :vcr do
    pj = MovieService.movie_data(49_022)

    expect(pj).to be_a Hash
    expect(pj[:id]).to eq(49_022)
  end
end
