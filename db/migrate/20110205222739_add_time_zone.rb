class AddTimeZone < ActiveRecord::Migration
  def self.up
    add_column :users, :time_zone, :string, :null => false, :default =>  "Pacific Time (US & Canada)"
  end

  def self.down
    remove_column :users, :time_zone
  end
end
