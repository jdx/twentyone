class AddCurrentHabitIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :current_habit_id, :integer
    User.all.each do |user|
      if user.habits.any?
        user.current_habit_id = user.habits.first.id
        user.save
        puts "updated current habit for: #{ user }"
      end
    end
  end

  def self.down
    remove_column :users, :current_habit_id
  end
end
