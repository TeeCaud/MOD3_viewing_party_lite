# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movie Search' do
  it 'allows users to search for movies', :vcr do
    user = User.create!(name: 'tee123', email: 'tee@tee.com', password: 'test123', password_confirmation: 'test123')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: 'test', password_confirmation: 'test')

    visit '/discover'

    fill_in 'Search', with: 'someThing'
    click_button 'Find Movies'

    expect(page.status_code).to eq(200)
    expect(page).to have_content('40 Total Results')

    within '#result-0' do
      expect(page).to have_content('Family Guy Presents: Something, Something, Something, Dark Side - Rated 7.3')
    end
    within '#result-1' do
      expect(page).to have_content("There's Something About Mary")
    end
  end
end
