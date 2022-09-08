class ApplicationController < ActionController::Base
  helper_method :current_user
# ^^ This allows it available in the view.


  # def index
  #   cookies[:secret_message] ||= "this is memoization"
  #   cookies.signed[:secret_message] ||= 'this is readable, but not editable'
  #   cookies.encrypted[:secret_message]
  #
  #   session[:user_id] = encrypted cookie under the hood
  # end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if !current_user
      redirect_to root_path
      flash[:alert] = "you must be logged in"
    end
  end


  def home
    @users = User.all
  end
end
