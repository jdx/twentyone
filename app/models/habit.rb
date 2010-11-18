class Habit < ActiveRecord::Base
  validates_presence_of :user_id, :what
  belongs_to :user
  has_many :habit_days, :order => :date
  before_destroy :delete_habit_days

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

  def finished_dates
    finished_dates = []
    self.habit_days.each { |f| finished_dates << f.date }
    return finished_dates
  end

  def notification_time
    return self.next_notification.localtime.strftime('%I:%M %p').sub(/^0?(.*)$/, '\1') if self.next_notification
    return nil
  end

  def set_notification_hour(hour=8, tomorrow=false)
    if Time.now.hour > hour or tomorrow
      d = DateTime.parse("#{ Date.today + 1.day }T#{ hour }:00:00-800")
    else
      d = DateTime.parse("#{ Date.today }T#{ hour }:00:00-800")
    end
    self.next_notification = Time.parse(d.to_s)
    self.save
  end

  def start_date
    return self.habit_days.first ? self.habit_days.first.date : Date.today
  end
  
  def send_notification
    logger.info "Sending notification to #{ self.user }"
    if self.user.phone_number
      self.next_notification = self.set_notification_hour(self.next_notification.hour, true)
      self.save
      TwilioHelper.send_sms(self.user.phone_number, "Day #{ self.current_day } of #{ self }. You've missed #{ self.missed_days } days. To complete, reply DONE.")
    else
      # user has no phone number, delete the notification
      self.next_notification = nil
      self.save()
    end
  end

  def delete_habit_days
    self.habit_days.each { |h| h.destroy }
  end

end
