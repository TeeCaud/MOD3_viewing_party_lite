# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'register page' do
  before :each do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: 'test', password_confirmation: 'test')

    visit new_user_path
  end

  it 'can register a user by unique email' do
    user = User.create!(name: 'tee123', email: 'tee@tee.com', password: 'test123', password_confirmation: 'test123')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    fill_in 'Name', with: 'Tyler'
    fill_in 'Email', with: 'tyler@user.com'
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: '123'
    click_on('Submit')
    expect(current_path).to eq("/users/#{User.last.id}")
  end
end
