class Admin::HabitController < Admin::AdminController
  def index
    @habits = Habit.all
  end

  def show
    @habit = Habit.find_by_id(params[:id])
  end
end
