# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Dashboard' do
  context 'user discover movie button' do
    it 'has a button to discover movies' do
      user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com')
      user2 = User.create!(name: 'Cary Berry', email: 'caryb@viewingparty.com')

      visit user_path(user1.id)

      expect(page).to have_content("Jim Bob's Dashboard")
      expect(page).to_not have_content("Cary Berry's Dashboard")
      expect(page).to have_selector(:link_or_button, 'Discover Movies')
    end

    it 'can take you to the discover movie page from a users dashboard' do
      user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com')

      visit user_path(user1.id)

      curr_path = user_discover_path(user1.id)

      click_on 'Discover Movies'

      expect(page).to have_current_path(curr_path)
      expect(page).to have_content('Discover Movies')
      expect(page).to have_field(:search)
      expect(page).to have_selector(:link_or_button, 'Find Movies')
    end

    it 'can have view parties for a user' do
      user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com')
      event = Event.create!(duration: 112, day: Date.today, start_time: '7:00PM', movie_title: 'Something Borrowed')
      user_event = UserEvent.create!(user_id: user1.id, event_id: event.id)

      visit user_path(user1.id)

      expect(page).to have_content('Something Borrowed')
      expect(page).to have_content('7:00PM')
      expect(page).to have_content('2022-08-26 00:00:00 UTC')
    end
  end
end
