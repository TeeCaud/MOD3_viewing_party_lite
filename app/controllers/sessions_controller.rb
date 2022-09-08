class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
      flash[:success] = "Welcome back, #{user.name}!"
    else
      redirect_to new_session_path
      flash[:error] = "Username or password are not correct."
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end
