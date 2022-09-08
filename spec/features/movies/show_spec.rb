# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movie Show page' do
  describe 'movie details' do
    before :each do
      @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: 'test', password_confirmation: 'test')
      @user2 = User.create!(name: 'Cary Berry', email: 'caryb@viewingparty.com', password: 'test', password_confirmation: 'test')
    end

    it 'has the movie title', :vcr do
      @movie = MovieFacade.movie_details(49_022)

      visit movie_path(@movie.id)

      expect(page).to have_content('Something Borrowed')
    end

    it 'has link to create new viewing party', :vcr do
      @movie = MovieFacade.movie_details(49_022)

      visit movie_path(@movie.id)

      expect(page).to have_link('New Viewing Party For Something Borrowed')
      expect(page).to have_content('Something Borrowed')
    end

    it 'has a button to the discover page', :vcr do
      @movie = MovieFacade.movie_details(49_022)
      visit movie_path(@movie.id)
      expect(page).to have_button('Discover Movies')
    end

    it 'has a button to create a viewing party', :vcr do
      @movie = MovieFacade.movie_details(49_022)
      visit movie_path(@movie.id)

      expect(page).to have_link("New Viewing Party For #{@movie.title}")
    end

    it 'shows movie attributes', :vcr do
      @movie = MovieFacade.movie_details(49_022)
      visit movie_path(@movie.id)

      expect(page).to have_content('Something Borrowed')
      expect(page).to have_content('6.3')
      expect(page).to have_content("Summary: Though Rachel is a successful attorney and a loyal, generous friend, she is still single. After one drink too many at her 30th-birthday celebration, Rachel unexpectedly falls into bed with her longtime crush, Dex -- who happens to be engaged to her best friend, Darcy. Ramifications of the liaison threaten to destroy the women's lifelong friendship, while Ethan, Rachel's confidant, harbors a potentially explosive secret of his own.")
      expect(page).to have_content(901)
    end

    it 'shows the movies cast', :vcr do
      @movie = MovieFacade.cast(49_022)
      visit movie_path(@movie.id)
    end

    it 'will only allow me to create a viewing party if logged in' do
      user = User.create!(name: 'tee123', email: 'tee@tee.com', password: 'test123', password_confirmation: 'test123')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
  end
end
