class HabitController < ApplicationController
  before_filter :require_login

  def create
    if @current_user.current_habit
      return redirect_to :action => :view
    end
    if request.post?
      what = params[:what]
      start_date = params[:when]
      unless what and not what.blank?
        flash[:error] = "You gotta say what you're going to do."
        return
      end
      Habit.create :what => what, :start_date => start_date, :user => @current_user
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
    today ||= habit.habit_days.find_by_date Date.today
    if today
      today.destroy
      result = { :status => "Removed" }
    else
      HabitDay.create :habit => habit, :date => Date.today
      result = { :status => "Created" }
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
