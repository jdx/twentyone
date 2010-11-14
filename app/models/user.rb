class User < ActiveRecord::Base
  validates_presence_of :facebook_id
  validates_uniqueness_of :facebook_id
  has_many :habits
end
