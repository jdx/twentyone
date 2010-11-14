class HabitDay < ActiveRecord::Base
  validates_presence_of :date, :habit
  belongs_to :habit
end
