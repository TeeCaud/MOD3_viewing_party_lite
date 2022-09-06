# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users show page' do
  before :each do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: 'test', password_confirmation: 'test')
  end

  it 'has displays the users dashboard' do
    visit user_path(@user1)
    expect(page).to have_content("Jim Bob's Dashboard")
    expect(page).to have_button('Discover Movies')
  end
end
