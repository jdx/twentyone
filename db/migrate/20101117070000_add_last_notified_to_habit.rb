class AddLastNotifiedToHabit < ActiveRecord::Migration
  def self.up
    add_column :habits, :last_notified, :date
  end

  def self.down
    remove_column :habits, :last_notified
  end
end
