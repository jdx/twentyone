class HabitController < ApplicationController

  def create
    if @current_user.habits.any?
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
    unless @current_user.habits.any?
      return redirect_to :action => :create
    end
    habits = @current_user.habits.all(:order => 'start_date DESC')
    @habit = habits[0]
    @finished_dates = []
    @habit.habit_days.each { |f| @finished_dates << f.date }
    logger.debug @finished_dates.inspect
  end

  def toggle_today
    unless @current_user.habits.any?
      return redirect_to :action => :create
    end
    habits = @current_user.habits.all(:order => 'start_date DESC')
    habit = habits[0]
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
    unless @current_user.habits.any?
      return redirect_to :action => :create
    end
    habits = @current_user.habits.all(:order => 'start_date DESC')
    @habit = habits[0]
    if request.post?
      @habit.habit_days.each { |h| h.destroy }
      @habit.destroy
      flash[:notice] = "You have canceled your habit."
      return redirect_to :action => :create
    end
  end

end
