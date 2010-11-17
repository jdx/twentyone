require 'twilio_helper'

class NotificationsController < ApplicationController
  skip_before_filter :require_login, :only => :send_all

  def send_all
    unless request.post?
      return render :nothing => true, :status => 404
    end
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
    @habit = @current_user.current_habit
    @habit.notification_hour = params[:hour].to_i
    @habit.user.phone_number = params[:phone]

    # validation
    @errors = {}
    if @habit.user.phone_number.blank?
      @errors["phone"] = "Phone number cannot be blank."
    elsif @habit.user.phone_number =~ /^\+?1?-?\(?\d{3}\)?-? ?\d{3} ?-?\d{4}$/
      phone = @habit.user.phone_number.sub(/^\+?1?-?\(?(\d{3})\)?-? ?(\d{3}) ?-?(\d{4})$/, '+1\1\2\3')
    else
      @errors["phone"] = "Invalid phone number."
    end

    unless @errors.any?
      @habit.user.phone_number = phone
      @habit.user.save()
      d = DateTime.now
      t = Time.now
      if Time.now.hour < @habit.notification_hour
        #@habit.next_notification = DateTime.ordinal(n.year, n.month, n.day + 1, @habit.notification_hour, 0, 0, n.offset)
      else
        #@habit.next_notification = DateTime.ordinal(n.year, n.month, n.day, @habit.notification_hour, 0, 0, n.offset)
      end
      logger.debug @habit.next_notification
      @habit.save()
      flash[:error] = "Notifications not working yet"
    end

    return render :template => 'habit/view'
  end
end
