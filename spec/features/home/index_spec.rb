# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home page' do
  before :each do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: 'test', password_confirmation: 'test')
    @user2 = User.create!(name: 'Cary Berry', email: 'caryb@viewingparty.com', password: 'test', password_confirmation: 'test')

    visit root_path
  end

  it 'title of application, links to existing user, button to create a new user' do
    expect(page).to have_content('Viewing Party Lite')
    expect(page).to have_button('Create a New User')
    expect(page).to have_link('jimb@viewingparty.com')
    expect(page).to have_link('caryb@viewingparty.com')
    expect(page).to have_link('Home')
    expect(page).to_not have_link('Tyler')
  end

  it 'can direct to create a new user' do
    click_button('Create a New User')
    expect(current_path).to eq('/register')
  end

  it 'has an index of existing users' do
    within("#user-#{@user1.id}") do
      expect(page).to have_link('jimb@viewingparty.com')
      click_link('jimb@viewingparty.com')
      expect(current_path).to eq("/users/#{@user1.id}")
    end
    expect(page).to have_content("Jim Bob's Dashboard")
  end

  it 'has a link to log in' do
    expect(page).to have_link('Log in')
    click_link 'Log in'
    expect(current_path).to eq('/login')

    email = 'jimb@viewingparty.com'
    password = 'test'
    click_on 'Submit'

    expect(current_path).to eq("/users/#{@user1.id}")


  end
end
