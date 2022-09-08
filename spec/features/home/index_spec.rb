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
    user = User.create!(name: 'tee123', email: 'tee@tee.com', password: 'test123', password_confirmation: 'test123')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    click_button('Create a New User')
    expect(current_path).to eq(new_user_path)
  end

  it 'has an index of existing users' do
    user = User.create!(name: 'tee123', email: 'tee@tee.com', password: 'test123', password_confirmation: 'test123')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

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
    expect(current_path).to eq(new_session_path)

    email = 'jimb@viewingparty.com'
    password = 'test'

    fill_in "Email", with: email
    fill_in "Password", with: password
    click_on 'Submit'

    expect(current_path).to eq("/users/#{@user1.id}")
    expect(page).to have_content("Welcome back, #{@user1.name}!")
  end

  it 'sad path email for login' do
    expect(page).to have_link('Log in')
    click_link 'Log in'
    expect(current_path).to eq(new_session_path)
    email = 'jimb@viewingparty.com'
    password = 'test'

    fill_in "Email", with: "asdf"
    fill_in "Password", with: password
    click_on 'Submit'

    expect(current_path).to eq(new_session_path)
    expect(page).to have_content("Username or password are not correct.")
  end

  it 'sad path email for login' do
    expect(page).to have_link('Log in')
    click_link 'Log in'
    expect(current_path).to eq(new_session_path)
    email = 'jimb@viewingparty.com'
    password = 'test'

    fill_in "Email", with: email
    fill_in "Password", with: "not password"
    click_on 'Submit'

    expect(current_path).to eq(new_session_path)
    expect(page).to have_content("Username or password are not correct.")
  end

  it 'if logged in, no link to log in or create an account do' do
    expect(page).to have_link('Log in')
    click_link 'Log in'
    expect(current_path).to eq(new_session_path)

    email = 'jimb@viewingparty.com'
    password = 'test'

    fill_in "Email", with: email
    fill_in "Password", with: password
    click_on 'Submit'
    expect(current_path).to eq("/users/#{@user1.id}")

    visit root_path
    expect(page).to_not have_link('Log in')
    expect(page).to_not have_button('Create a New User')
    expect(page).to have_link('Log out')
    click_link 'Log out'
    expect(current_path).to eq(root_path)
    expect(page).to have_link('Log in')
    expect(page).to have_button('Create a New User')
  end

  it 'can only go to dashboard if authorized' do
    visit user_path(@user1)
    expect(current_path).to eq(root_path)
    expect(page).to have_content('you must be logged in')
  end
end
