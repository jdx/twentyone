class RemoveFacebookIdFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :facebook_id
  end

  def self.down
    add_column :users, :facebook_id, :integer
  end
end
