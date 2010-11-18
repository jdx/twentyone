class TwilioController < ApplicationController
  skip_before_filter :require_login
  skip_before_filter :verify_authenticity_token

  def sms
    unless request.post?
      return render :nothing => true, :status => 404
    end
    body = params[:Body].upcase.strip
    @current_user ||= User.find_by_phone_number(params[:From])
    if @current_user
      if @current_user.current_habit
        if body == 'STOP'
          return stop
        elsif body == 'STATUS'
          return status
        elsif body == 'DONE'
          return done
        else
          return unknown_request
        end
      else
        return nohabit
      end
    else
      @current_user ||= User.find_by_sms_code(body.downcase)
      if @current_user
        return setup_user(params[:From])
      else
        return unknown_user
      end
    end

  end

protected

  def done
    today ||= @current_user.current_habit.habit_days.find_by_date(Date.today)
    unless today
      HabitDay.create :habit => @current_user.current_habit, :date => Date.today
    end
    response = "Sweet! You've completed #{ @current_user.current_habit.habit_days.count }/21 days!"
    return render :text => response.strip, :content_type => 'text/plain'
  end

  def status
    response = "#{ @current_user.current_habit.habit_days.count }/21 days of #{ @current_user.current_habit }. Missed #{ @current_user.current_habit.missed_days } days."
    return render :text => response.strip, :content_type => 'text/plain'
  end

  def stop
    @current_user.phone_number = nil
    @current_user.save
    response = "You are no longer receiving daily notifications."
    return render :text => response.strip, :content_type => 'text/plain'
  end

  def unknown_request
    response = "Say DONE to complete your habit today. STATUS to check your habit's status. STOP to stop notifications."
    return render :text => response.strip, :content_type => 'text/plain'
  end

  def nohabit
    response = "You don't have a current habit. Go to twentyonedayhabit.com and make one!"
    return render :text => response.strip, :content_type => 'text/plain'
  end

  def setup_user(phone_number)
    @current_user.phone_number = phone_number
    @current_user.current_habit.set_notification_hour
    @current_user.save
    response = "Got it, #{ @current_user }! You are now receiving notifications at #{ @current_user.current_habit.notification_time }. Go to twentyonedayhabit.com to change the time."
    return render :text => response.strip, :content_type => 'text/plain'
  end

  def unknown_user
    response = "I don't know who you are! Sign up at twentyonedayhabit.com first!"
    return render :text => response.strip, :content_type => 'text/plain'
  end

end
