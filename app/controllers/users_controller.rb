# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new; end

  def discover
    @user = User.find(params[:user_id])
  end

  def login_forum
  end

  def create
    new_user = User.create!(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      redirect_to "/users/#{User.last.id}"
      # redirect_to user_path
      flash[:success] = "Welcome, #{new_user.name}"
    else
      redirect_to '/register'
      flash[:error] = user.errors.full_messages 
    end
  end

  # if user&.authenticate(params[:password])

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
