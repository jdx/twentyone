class Habit < ActiveRecord::Base
  validates_presence_of :user_id, :what, :start_date
  belongs_to :user
  has_many :habit_days
end
