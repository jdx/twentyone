class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

protected
  def current_user
    cookie = request.cookies['fbs_' + ENV['FB_APP_ID']]
    unless cookie
      return
    end
    cookie = CGI.parse cookie
    uid = cookie["uid"][0].to_i
    @current_user ||= User.find_by_facebook_id(uid)
    unless @current_user
      access_token = cookie['"access_token'][0]
      fbuser = FbGraph::User.me(access_token).fetch
      @current_user = User.create({
        :first_name => fbuser.first_name,
        :last_name => fbuser.last_name,
        :facebook_id => uid
      })
    end
    return @current_user
  end

  def logged_in?
    !!current_user
  end

  helper_method :current_user, :logged_in?

  def require_login
    unless logged_in?
      redirect_to :login
    end
  end

  def require_admin
    unless @current_user.admin?
      flash[:error] = "This page is available to administrators only"
      redirect_to root
    end
  end
end
