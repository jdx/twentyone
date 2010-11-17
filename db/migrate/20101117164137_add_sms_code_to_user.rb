class AddSmsCodeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :sms_code, :string
    User.all.each do |user|
      user.sms_code = Digest::MD5.hexdigest(user.to_s + Time.now.to_s)[1..8]
      user.save
      puts "Updated user #{ user }. Set sms_code to #{ user.sms_code }."
    end
  end

  def self.down
    remove_column :users, :sms_code
  end
end
