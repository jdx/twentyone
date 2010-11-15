class ChangeFacebookIdToBigIntOnUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :facebook_id, 'bigint'
  end

  def self.down
  end
end
