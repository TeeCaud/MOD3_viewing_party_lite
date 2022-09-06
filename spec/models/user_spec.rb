# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of(:password_digest)}
    it { should have_secure_password }

    it { should validate_uniqueness_of :email }
  end

  describe 'relationships' do
    it { should have_many(:events).through(:user_events) }
  end

  describe 'passwords' do
    it 'validates a password' do
      user = User.create(name: 'Meg', email: 'meg@test.com', password: 'password123', password_confirmation: 'password123')

      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end
  end
end
