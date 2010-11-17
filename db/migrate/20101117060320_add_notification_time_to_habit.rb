class AddNotificationTimeToHabit < ActiveRecord::Migration
  def self.up
    add_column :habits, :notification_time, :time
  end

  def self.down
    remove_column :habits, :notification_time
  end
end
