require 'digest/md5'

class User < ActiveRecord::Base
  has_many :habits
  belongs_to :current_habit, :foreign_key => "current_habit_id", :class_name => "Habit"
  validates_uniqueness_of :username, :allow_nil => true
  validates_uniqueness_of :facebook_identifier, :allow_nil => true
  validates_uniqueness_of :phone_number, :allow_nil => true
  validates_uniqueness_of :sms_code
  before_create :set_sms_code
  before_destroy :delete_habits

  def name
    return "%s %s" % [ self.first_name, self.last_name ]
  end

  def to_s
    if not self.name.blank?
      self.name
    elsif not self.username.blank?
      self.username
    else
      self.id
    end
  end

  def friends
    cached = User.where(:facebook_identifier => facebook_friend_ids)
  end

protected

  def facebook_friend_ids
    cache_key = "user_#{ self.id }_friends"
    fb_ids = Rails.cache.read(cache_key)
    unless fb_ids
      fb_ids = []
      fbuser.friends.each { |f| fb_ids << f.identifier }
      Rails.cache.write(cache_key, fb_ids)
    end
    logger.debug fb_ids.inspect
    return fb_ids
  end

  def fbuser
    access_token = self.facebook_access_token
    return FbGraph::User.me(access_token)
  end

  def set_sms_code
    self.sms_code = Digest::MD5.hexdigest(self.to_s + Time.now.to_s)[1..8]
  end

  def delete_habits
    self.habits.each { |h| h.destroy }
  end
end
