class UnifyNotificationTimesOnHabits < ActiveRecord::Migration
  def self.up
    remove_column :habits, :notification_time
    remove_column :habits, :last_notified
    add_column :habits, :next_notification, :datetime
  end

  def self.down
    add_column :habits, :last_notified, :date
    add_column :habits, :notification_time, :time
  end
end
