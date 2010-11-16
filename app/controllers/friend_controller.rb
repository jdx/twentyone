class FriendController < ApplicationController
  before_filter :require_login
  def index
    fb_ids = []
    fbuser.friends.each { |f| fb_ids << f.identifier }
    @friends = User.where(:facebook_identifier => fb_ids)
  end
end
