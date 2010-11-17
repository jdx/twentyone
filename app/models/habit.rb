class Habit < ActiveRecord::Base
  validates_presence_of :user_id, :what, :start_date
  belongs_to :user
  has_many :habit_days

  def to_s
    return self.what.sub(/\.$/, '')
  end

  def missed_days
    return ((Date.today - self.start_date) - HabitDay.where('habit_id = ? AND date < ?', self.id, Date.today).count).to_i
  end

  def days_completed
    return self.habit_days.count
  end

  def current_day
    return (Date.today + 1 - self.start_date).to_i
  end
  
  def send_notification
    logger.info "Sending notification to #{ self.user }"
    if self.user.phone_number
      self.next_notification = self.next_notification + 1.day
      self.save
      TwilioHelper.send_sms(self.user.phone_number, "Day #{ self.current_day } of #{ self }. You've missed #{ self.missed_days } days. To complete, reply DONE.")
    else
      # user has no phone number, delete the notification
      self.next_notification = nil
      self.save()
    end
  end
end
