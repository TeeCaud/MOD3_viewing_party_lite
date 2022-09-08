# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users show page' do
  before :each do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: 'test', password_confirmation: 'test')
  end

  it 'has displays the users dashboard' do
    user = User.create!(name: 'tee123', email: 'tee@tee.com', password: 'test123', password_confirmation: 'test123')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit user_path(@user1)
    expect(page).to have_content("Jim Bob's Dashboard")
    expect(page).to have_button('Discover Movies')
  end
end
