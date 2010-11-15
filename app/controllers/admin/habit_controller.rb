class Admin::HabitController < ApplicationController
  before_filter :require_admin

  def index
    @habits = Habit.all
  end

  def show
    @habit = Habit.find_by_id(params[:id])
  end
end
