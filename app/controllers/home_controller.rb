class HomeController < ApplicationController
  skip_before_filter :require_login, :only => :login

  def login
    if logged_in?
      if @current_user.habits.any?
        return redirect_to :controller => :habit, :action => :create
      else
        return redirect_to :controller => :habit, :action => :view
      end
    end
  end
end
