
class User < ActiveRecord::Base
  
  attr_accessible :name, :password, :password_confirmation
  has_secure_password
  
  validates_confirmation_of :password
  validates_presence_of :name
  validates_presence_of :password, on: :create
  validates_uniqueness_of :name

  after_destroy :ensure_at_least_one_admin_remains

  def ensure_at_least_one_admin_remains
  	if User.count.zero?
  		raise "At least one admin must remains"
  	end
  end
  
end
