class HabitController < ApplicationController
  def create
    if request.get?
    end
    if request.post?
      params[:what]
      params[:when]
      return redirect_to :action => :view
    end
  end
  def view
    unless @current_user.habits.any?
      return redirect_to :action => :create
    end
    @current_user.habits.all(:order => 'start_date DESC')

  end
  def today
  end
end
