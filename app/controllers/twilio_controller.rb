class TwilioController < ApplicationController
  skip_before_filter :require_login
  skip_before_filter :verify_authenticity_token

  def sms
    unless request.post?
      return render :nothing => true, :status => 404
    end
    body = params[:Body].upcase.strip
    user ||= User.find_by_phone_number(params[:From])
    if user
      if user.current_habit

        if body == 'STOP'
          user.current_habit.notification_time = nil
          user.save()
          return render :text => "You are no longer receiving daily notifications."

        elsif body == 'STATUS'
          response = "You've completed #{ user.current_habit.habit_days.count }/21 days of #{ user.current_habit }. "
          if user.current_habit.notification_time
            response = response + "You receive daily notifications at #{ user.current_habit.notification_time }."
          else
            response = response + "You don't receive daily notifications. Go to http://twentyonedayhabit.com/ to start!"
          end
          return render :text => response

        elsif body == 'DONE'
          today ||= user.current_habit.habit_days.find_by_date(Date.today)
          unless today
            HabitDay.create :habit => user.current_habit, :date => Date.today
          end
          return render :text => "Sweet! You've completed #{ user.current_habit.habit_days.count }/21 days!"

        else
          response = "I don't understand that. Say DONE to complete your habit today. Say STATUS to check your habit's status. "
          response = response + "Say STOP to stop receiving notifications." if user.notification_time
          return render :text => response.strip
        end

      else
        return render :text => "You don't have a current habit. Go to http://twentyonedayhabit.com/ and make one!"
      end

    else
      return render :text => "I don't know who you are! Sign up at http://twentyonedayhabit.com/ first!"
    end

  end

end
