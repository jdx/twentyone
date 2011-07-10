require 'twilio_helper'

class NotificationsController < ApplicationController
  skip_before_filter :require_login, :only => :send_all

  def send_all
    logger.info 'Sending notifications...'
    Habit.where('next_notification < ?', DateTime.now).each do |habit|
      habit.send_notification
    end
    return render :text => 'Sent notifications.', :content_type => 'text/plain'
  end

  def edit
    unless request.post?
      return render :nothing => true, :status => 404
    end
    @current_user.current_habit.set_notification_hour(params[:hour].to_i)
    TwilioHelper.send_sms(@current_user.phone_number, "You are now receiving notifications at #{ @current_user.current_habit.notification_time }.")
    return render :json => { :hour => params[:hour], :time => @current_user.current_habit.notification_time }
  end
end
