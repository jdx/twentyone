require 'open-uri'

class FacebookController < ApplicationController
  skip_before_filter :require_login
  rescue_from OpenURI::HTTPError, :with => :facebook_error

  def login
    uri = "https://graph.facebook.com/oauth/authorize?client_id=#{ ENV['FB_APP_ID'] }&redirect_uri=#{ auth_facebook_callback_url }"
    redirect_to uri
  end

  def facebook_error
    flash[:error] = "Error talking to Facebook, try again. If it still doesn't work, log out of Facebook and try it again."
    redirect_to root_url
  end

  def callback
    uri = "https://graph.facebook.com/oauth/access_token?client_id=#{ ENV['FB_APP_ID'] }&redirect_uri=#{ auth_facebook_callback_url }&client_secret=#{ ENV['FB_APP_SECRET'] }&code=#{ CGI::escape(params[:code]) }"
    response = open(uri).read
    access_token = CGI.parse(response)["access_token"][0]
    fb_user = FbGraph::User.me(access_token).fetch
    user ||= User.find_by_facebook_identifier fb_user.identifier
    if user 
      if session[:user_id]
        unless user.id == session[:user_id]
          # The user is merging an account
          # This is complicated, all data needs to be moved over
          # Fucking users trying to screw up my data... boy I tell ya
          old_user = user
          user = User.find_by_id(session[:user_id])
          old_user.habits.each do |h|
            h.user = user
            h.save()
          end
          old_user.destroy()
        end
      end
    else
      if session[:user_id]
        # They're logging in via facebook for their first time
        user = User.find_by_id(session[:user_id])
      else
        # Next easiest case, the user is signing in via facebook for the first time
        # Let's just create the user
        user = User.create({:first_name => fb_user.first_name,
                            :last_name => fb_user.last_name,
                            :admin => false,
                            :facebook_identifier => fb_user.identifier})
      end
    end
    user.first_name = fb_user.first_name
    user.last_name = fb_user.last_name
    user.facebook_identifier = fb_user.identifier
    user.facebook_access_token = access_token
    user.save()
    session[:user_id] = user.id
    return redirect_to root_path
  end

  def link
  end
end
