class FriendController < ApplicationController
  before_filter :require_login
  def index
    fbuser = fb_user
    unless fbuser
      flash[:error] = "Error with facebook"
      return redirect_to root_path
    end
    fb_ids = []
    fbuser.friends.each { |f| fb_ids << f.identifier }
    @friends = User.where :facebook_identifier => fb_ids
  end
end
