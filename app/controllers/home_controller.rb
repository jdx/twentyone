class HomeController < ApplicationController
  skip_before_filter :require_login, :only => :login

  def index
    unless @current_user.habits.any?
      return redirect_to :controller => :habit, :action => :create
    end
  end

  def login
    if logged_in?
      return redirect_to :action => :index
    end
  end
end
