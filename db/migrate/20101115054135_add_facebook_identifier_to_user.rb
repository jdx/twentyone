class AddFacebookIdentifierToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :facebook_identifier, :string
  end

  def self.down
    remove_column :users, :facebook_identifier
  end
end
