class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :habit_days, :habit_id
    add_index :habit_days, :date
    add_index :habits, :user_id
    add_index :habits, :start_date
    add_index :users, :facebook_identifier
    add_index :users, :username
  end

  def self.down
    remove_index :habit_days, :habit_id
    remove_index :habit_days, :date
    remove_index :habits, :user_id
    remove_index :habits, :start_date
    remove_index :users, :facebook_identifier
    remove_index :users, :username
  end
end
