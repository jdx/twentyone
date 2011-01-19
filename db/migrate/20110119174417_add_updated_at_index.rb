class AddNextNotificationIndex < ActiveRecord::Migration
  def self.up
    add_index :users, :updated_at
  end

  def self.down
    remove_index :users, :updated_at
  end
end
