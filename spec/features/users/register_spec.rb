require 'rails_helper'

RSpec.describe 'register page' do
  before :each do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: 'test', password_confirmation: 'test')
  end

  it 'has a form to register a user' do
    user = User.create!(name: 'tee123', email: 'tee@tee.com', password: 'test123', password_confirmation: 'test123')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_user_path

    name = "Tee"
    email = "tee@test.com"
    password = "test"

    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password
    click_on "Submit"

    expect(current_path).to eq("/users/#{User.last.id}")
  end

  it 'sad path for non matching passwords' do
    user = User.create!(name: 'tee123', email: 'tee@tee.com', password: 'test123', password_confirmation: 'test123')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_user_path

    name = "Tee"
    email = "tee@test.com"
    password = "test"

    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: 'sdf'
    click_on "Submit"

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it 'sad path for existing email' do
    visit new_user_path

    name = "Tee"
    email = "jimb@viewingparty.com"
    password = "test"

    fill_in :name, with: name
    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: 'sdf'
    click_on "Submit"

    expect(page).to have_content("Email has already been taken")
  end
end
