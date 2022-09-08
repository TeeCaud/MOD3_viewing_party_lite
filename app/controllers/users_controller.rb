class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create, :discover]
  # this is a call back

  def show
    @user = User.find(params[:id])
  end

  def new; end

  def discover
    # @user = User.find(params[:user_id])
  end

  def create
    new_user = User.create(user_params)
    if new_user.save
      session[:user_id] = new_user.id
      redirect_to user_path(new_user)
      flash[:success] = "Welcome, #{new_user.name}"
    else
      redirect_to new_user_path
      flash[:error] = new_user.errors.full_messages
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
