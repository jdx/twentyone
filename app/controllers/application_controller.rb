class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
      @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
      !!current_user
  end

  def current_user=(user)
      @current_suer = user
      session[:user_id] = user.id
  end
end
