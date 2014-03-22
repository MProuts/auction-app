class User < ActiveRecord::Base
  validates_uniqueness_of :email
  validates_presence_of :email, :name, :password, :password_confirmation

  has_many :listings, :class_name => "Auction", :foreign_key => "seller_id"
  has_many :bids, :foreign_key => "bidder_id"
  has_secure_password
end
