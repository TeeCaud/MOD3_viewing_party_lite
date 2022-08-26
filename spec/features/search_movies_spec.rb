# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Movie Search' do
  it 'allows users to search for movies', :vcr do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com')

    visit user_discover_path(@user1.id)

    fill_in 'Search', with: 'someThing'
    click_button 'Find Movies'

    expect(page.status_code).to eq(200)
    expect(page).to have_content('40 Total Results')

    within '#result-0' do
      expect(page).to have_content('Something Borrowed')
    end
    within '#result-1' do
      expect(page).to have_content("There's Something About Mary")
    end
  end
end
