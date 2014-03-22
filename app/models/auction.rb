class Auction < ActiveRecord::Base
  validates_presence_of :title, :end_time
  validates_uniqueness_of :title
  validate :has_not_ended
  belongs_to :seller, :class_name => "User"
  has_many :bids

  def ended?
    self.end_time < Time.now
  end

  def has_not_ended
    errors.add(:end_time, "must be in the future.") if ended?
  end

  def current_bid 
    bids.where(amount: bids.maximum(:amount)).first
  end
end
