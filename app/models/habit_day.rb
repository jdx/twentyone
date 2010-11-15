class HabitDay < ActiveRecord::Base
  validates_presence_of :date, :habit, :time
  belongs_to :habit
end
