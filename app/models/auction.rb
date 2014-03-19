class Auction < ActiveRecord::Base
  validates_presence_of :title, :end_time
  validates_uniqueness_of :title
  validate :not_ended?
  belongs_to :seller, :class_name => "User"
  has_many :bids

  private
  def not_ended?
    if (self.end_time < Time.now)
      errors.add(:end_time, "must be in the future.")
    end
  end
end
