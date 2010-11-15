class Admin::UserController < ApplicationController
  before_filter :require_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
  end

end
