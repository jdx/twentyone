class HabitController < ApplicationController
  before_filter :require_login

  def create
    if @current_user.current_habit
      return redirect_to :action => :view
    end
    if request.post?
      what = params[:what]
      if what.blank?
        flash[:error] = "You gotta say what you're going to do."
        return
      end
      habit = Habit.create :what => what, :user => @current_user
      @current_user.time_zone = params[:user][:time_zone]
      @current_user.current_habit = habit
      @current_user.save!
      return redirect_to :action => :view
    end
  end

  def view
    unless @current_user.current_habit
      return redirect_to :action => :create
    end
    @habit = @current_user.current_habit
  end

  def toggle_today
    unless @current_user.current_habit
      return redirect_to :action => :create
    end
    habit = @current_user.current_habit
    today ||= habit.habit_days.find_by_date Time.zone.now.to_date
    if today
      today.destroy
      result = { :status => "Removed", :days_completed => habit.days_completed }
    else
      HabitDay.create :habit => habit, :date => Time.zone.now.to_date
      result = { :status => "Created", :days_completed => habit.days_completed }
    end
    respond_to do |format|
      format.html { redirect_to :action => :view }
      format.json { render :json => result }
    end
  end

  def cancel
    unless @current_user.current_habit
      return redirect_to :action => :create
    end
    @habit = @current_user.current_habit
    if request.post?
      @habit.destroy
      flash[:notice] = "You have canceled your habit."
      return redirect_to :action => :create
    end
  end

end
