# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Dashboard' do
  context 'user discover movie button' do
    it 'has a button to discover movies' do
      user = User.create!(name: 'tee123', email: 'tee@tee.com', password: 'test123', password_confirmation: 'test123')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: 'test', password_confirmation: 'test')

      visit user_path(user1.id)

      expect(page).to have_content("Jim Bob's Dashboard")
      expect(page).to_not have_content("Cary Berry's Dashboard")
      expect(page).to have_selector(:link_or_button, 'Discover Movies')
    end

    it 'can take you to the discover movie page from a users dashboard' do
      user = User.create!(name: 'tee123', email: 'tee@tee.com', password: 'test123', password_confirmation: 'test123')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: 'test', password_confirmation: 'test')

      visit user_path(user1.id)

      curr_path = '/discover'

      click_on 'Discover Movies'

      expect(page).to have_current_path(curr_path)
      expect(page).to have_content('Discover Movies')
      expect(page).to have_field(:search)
      expect(page).to have_selector(:link_or_button, 'Find Movies')
    end

    it 'can have view parties for a user' do
      user = User.create!(name: 'tee123', email: 'tee@tee.com', password: 'test123', password_confirmation: 'test123')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: 'test', password_confirmation: 'test')
      event = Event.create!(duration: 112, day: Date.today, start_time: '7:00PM', movie_title: 'Something Borrowed')
      user_event = UserEvent.create!(user_id: user1.id, event_id: event.id)

      visit user_path(user1.id)

      expect(page).to have_content('Something Borrowed')
      expect(page).to have_content('7:00PM')
      expect(page).to have_content('2022-09-07 00:00:00')
    end
  end
end
