# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event New Page' do
  before :each do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com')
    @user2 = User.create!(name: 'Cary Berry', email: 'caryb@viewingparty.com')
    @user3 = User.create!(name: 'Michael Cane', email: 'my@kokane.com')
    @user4 = User.create!(name: 'Leroy Jenkins', email: 'leeeroyyyyyy@hotmail.com')
    @movie = MovieFacade.movie_details(49_022)
  end

  context 'it has a form to make new event' do
    it 'has form for duration, day, and starttime', :vcr do
      visit "/users/#{@user1.id}/movies/#{@movie.id}"

      click_on "New Viewing Party For #{@movie.title}"

      expect(page).to have_content("Create Event For #{@movie.title}")
      expect(page).to have_content('Movie Title - Something Borrowed')
      expect(page).to have_field('Duration', with: 112)
      expect(page).to have_button('Create Event')
    end

    it 'can make a new event', :vcr do
      visit "/users/#{@user1.id}/movies/#{@movie.id}"

      click_on "New Viewing Party For #{@movie.title}"
      fill_in 'Duration', with: 112
      fill_in(:date, with: '2022/3/5')
      fill_in(:time, with: '7:30PM')
      check("user_ids_#{@user2.id}")
      check("user_ids_#{@user3.id}")

      click_on 'Create Event'

      expect(page).to have_current_path(user_path(@user1.id))
    end
  end
end
