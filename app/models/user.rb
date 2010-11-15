class User < ActiveRecord::Base
  validates_presence_of :facebook_id, :facebook_identifier
  validates_uniqueness_of :facebook_id, :facebook_identifier
  has_many :habits

  def name
    return "%s %s" % [ self.first_name, self.last_name ]
  end

  def current_habit
    habits = self.habits.all(:order => 'start_date DESC')
    return habits[0]
  end

end
