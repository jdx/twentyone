class CreateHabits < ActiveRecord::Migration
  def self.up
    create_table :habits do |t|
      t.integer :user_id
      t.date :start_date
      t.string :what

      t.timestamps
    end
  end

  def self.down
    drop_table :habits
  end
end
