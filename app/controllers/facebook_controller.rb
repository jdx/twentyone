require 'open-uri'

class FacebookController < ApplicationController
  skip_before_filter :require_login

  def login
    uri = "https://graph.facebook.com/oauth/authorize?client_id=#{ ENV['FB_APP_ID'] }&redirect_uri=#{ auth_facebook_callback_url }"
    redirect_to uri
  end

  def callback
    uri = "https://graph.facebook.com/oauth/access_token?client_id=#{ ENV['FB_APP_ID'] }&redirect_uri=#{ auth_facebook_callback_url }&client_secret=#{ ENV['FB_APP_SECRET'] }&code=#{ CGI::escape(params[:code]) }"
    response = open(uri).read
    access_token = CGI.parse(response)["access_token"][0]
    fb_user = FbGraph::User.me(access_token).fetch
    user ||= User.find_by_facebook_identifier fb_user.identifier
    unless user
      user = User.create { :first_name => fb_user.first_name,
                           :last_name => fb_user.last_name,
                           :admin => false,
                           :facebook_identifier => fb_user.identifier }
    end
    session[:user_id] = user.id
    return redirect_to root_path
  end
end
