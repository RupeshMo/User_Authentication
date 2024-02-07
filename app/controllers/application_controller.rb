class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] # if user id exists
  end

  def logged_in?
    !!current_user # boolean
  end

  def require_user
    if !logged_in?
      redirect_to login_path, notice: 'Not logged in to perform this action'
    end
  end
end
