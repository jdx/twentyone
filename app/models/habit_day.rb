class HabitDay < ActiveRecord::Base
  belongs_to :habit
  validates_presence_of :habit_id, :date
  validates_uniqueness_of :date, :scope => :habit_id
end
