class FriendController < ApplicationController
  before_filter :require_login
  def index
    @friends = @current_user.friends
  end
end
