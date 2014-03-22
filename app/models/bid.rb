class Bid < ActiveRecord::Base
  belongs_to :bidder, :class_name=> "User"
  belongs_to :auction
  validate :amount, :presence => true
  validates_presence_of :bidder_id, :auction_id
  validate :high_enough
  validate :auction_not_ended?

  def highest_bid_amount
    self.auction.bids.maximum(:amount)
  end

  def high_enough
    if highest_bid_amount && self.amount
      if highest_bid_amount > self.amount
        errors.add(:amount, "must exceed current bid.")
      end
    end
  end

  def auction_not_ended?
    errors[:auction] = "must not have ended" if auction.ended?
  end

  def amount_in_dollars
    self.amount / 100 if self.amount
  end

  def amount_in_dollars=(amount_in_dollars)
    if amount_in_dollars.to_i == 0
      self.amount = amount_in_dollars
    else
      self.amount = amount_in_dollars.to_i * 100
    end
  end
end
