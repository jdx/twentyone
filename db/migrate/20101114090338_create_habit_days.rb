class CreateHabitDays < ActiveRecord::Migration
  def self.up
    create_table :habit_days do |t|
      t.integer :habit_id
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :habit_days
  end
end
