require 'digest/md5'

class HomeController < ApplicationController
  skip_before_filter :require_login, :only => :login

  def index
    if @current_user.habits.any?
      return redirect_to :controller => :habit, :action => :view
    else
      return redirect_to :controller => :habit, :action => :create
    end
  end

  def login
    unless request.post?
      return redirect_to root_path
    end

    @username = params[:username]

    # Validation
    @errors = {}
    unless params[:username] =~ /^[A-Za-z](?=[A-Za-z0-9_.]{3,31}$)[a-zA-Z0-9_]*\.?[a-zA-Z0-9_]*$/
      @errors["username"] = "Invalid username."
    end
    if params[:username].blank?
      @errors["username"] = "Username can't be blank."
    end
    unless params[:password] =~ /^.{4,100}$/
      @errors["password"] = "Password must be at least 4 characters."
    end
    if params[:password].blank?
      @errors["password"] = "Password can't be blank."
    end
    if @errors.any?
      return render :action => :index
    end

    # Password/user lookup
    user ||= User.find_by_username(params[:username])
    if user
      if Digest::MD5.hexdigest(params[:password]) == user.password
        session[:user_id] = user.id
      else
        @errors["password"] = "Password for #{ user.username } invalid"
      end
    else
      user = User.create({:username => params[:username], :password => Digest::MD5.hexdigest(params[:password])})
      session[:user_id] = user.id
    end

    if @errors.any?
      return render :action => :index
    end
    redirect_to habit_create_path
  end

  def logout
    session.clear
    redirect_to root_path
  end
end
