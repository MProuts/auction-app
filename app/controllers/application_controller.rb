class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :log_in, :logged_in?, :current_user, :logged_in_with_id?

  def log_in user
    session[:user_id] = user.id
  end

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end

  def current_user? user
    current_user == user
  end

  def log_out!
    reset_session
  end

  def require_login
    redirect_to log_in_path, :notice => "Please sign in." unless logged_in?
  end

  def logged_in_with_id? id
    current_user && current_user.id == id
  end

end
