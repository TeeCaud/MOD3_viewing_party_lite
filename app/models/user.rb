# frozen_string_literal: true
\

class User < ApplicationRecord
  validates_presence_of :name,
                        :email,
                        :password_digest


  has_secure_password
  validates_uniqueness_of :email
  has_many :user_events
  has_many :events, through: :user_events
end
