class Bid < ActiveRecord::Base
  belongs_to :bidder, :class_name=> "User"
  belongs_to :auction
  validate :high_enough

  private
  def highest_bid_amount
    self.class.maximum(:amount)
  end

  def high_enough
    if highest_bid_amount > self.amount
      errors.add(:amount, "must be higher than the current high bid.")
    end
  end

end
