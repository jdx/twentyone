class AddNextNotificationIndex < ActiveRecord::Migration
  def self.up
    add_index :habits, :next_notification
  end

  def self.down
    remove_index :habits, :next_notification
  end
end
