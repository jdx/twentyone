class AddNotificationHourToHabit < ActiveRecord::Migration
  def self.up
    add_column :habits, :notification_hour, :integer
  end

  def self.down
    remove_column :habits, :notification_hour
  end
end
