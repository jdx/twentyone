class HomeController < ApplicationController
  skip_before_filter :require_login, :only => [ :index, :login ]

  def index
    if logged_in?
      if @current_user.habits.any?
        return redirect_to :controller => :habit, :action => :create
      else
        return redirect_to :controller => :habit, :action => :view
      end
    end
  end

  def login
  end

  def logout
    render :action => 'index'
  end
end
