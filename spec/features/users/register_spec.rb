require 'rails_helper'

RSpec.describe 'register page' do
  before :each do
    @user1 = User.create!(name: 'Jim Bob', email: 'jimb@viewingparty.com', password: 'test', password_confirmation: 'test')
  end

  it 'has a form to register a user' do
    visit '/register'

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
end
