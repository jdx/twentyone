class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_domain
  before_filter :require_login
  rescue_from FbGraph::Exception, :with => :fbexception

  def fbexception
    @current_user.facebook_access_token = nil
    @current_user.save
    if @current_user.facebook_identifier
      redirect_to auth_facebook_path
    else
      redirect_to facebook_link_path
    end
  end

protected
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  helper_method :current_user, :logged_in?, :fb_user

  def check_domain
    return redirect_to request.protocol + request.host_with_port[4..-1] + request.request_uri if /^www/.match(request.host)
    return redirect_to request.protocol + 'twentyonedayhabit.com' + request.request_uri if /heroku.com$/.match(request.host)
  end

  def require_login
    redirect_to :login unless logged_in?
  end

  def require_admin
    unless @current_user.admin?
      flash[:error] = "This page is available to administrators only"
      redirect_to root_path
    end
  end
end
