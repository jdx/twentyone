class User < ActiveRecord::Base
  has_many :habits

  def name
    return "%s %s" % [ self.first_name, self.last_name ]
  end

  def to_s
    if not self.name.blank?
      self.name
    elsif not self.username.blank?
      self.username
    else
      self.id
    end
  end

  def current_habit
    habits = self.habits.all(:order => 'start_date DESC')
    return habits[0]
  end

end
