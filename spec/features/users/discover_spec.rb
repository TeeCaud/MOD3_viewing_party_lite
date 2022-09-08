# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Discover page' do
  context 'discover movies search' do
    it 'goes to the search & redirects back to discover', :vcr do
      user = User.create!(name: 'tee123', email: 'tee@tee.com', password: 'test123', password_confirmation: 'test123')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: 'test', password_confirmation: 'test')

      curr_path = "/movies?utf8=%E2%9C%93&search=something&commit=Find+Movies"

      visit '/discover'

      fill_in 'Search', with: 'something'

      click_on 'Find Movies'

      expect(page).to have_current_path(curr_path)
      expect(page).to have_content('Something Borrowed')
    end

    it 'has a button to discover top rated movies and to find movies', :vcr do
      user = User.create!(name: 'tee123', email: 'tee@tee.com', password: 'test123', password_confirmation: 'test123')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: 'test', password_confirmation: 'test')
      visit '/discover'
      expect(page).to have_selector(:link_or_button, 'Find Top Rated Movies')
      click_on('Find Top Rated Movies')

      expect(current_path).to eq("/movies")
    end
  end
end
