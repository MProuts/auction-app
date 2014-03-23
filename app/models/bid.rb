class Bid < ActiveRecord::Base
  belongs_to :bidder, :class_name=> "User"
  belongs_to :auction
  validates_numericality_of :amount
  validates_presence_of :bidder_id, :auction_id, :amount
  validate :high_enough
  validate :auction_not_ended?
  validate :amount_numeric

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
    self.amount.to_i / 100 if self.amount
  end

  def amount_in_dollars=(amount_in_dollars)
    # numericality lost here if not saved to instance variable
    # 1) money in database integer, float, or string?
    # 2) numericality validations only work on strings b/c activerecord
    # typecasting?
    @amount_in_dollars = amount_in_dollars
    self.amount = amount_in_dollars.to_i * 100
  end

  def amount_numeric
    unless @amount_in_dollars.match(/\A[+-]?\d+\Z/)
      errors.add(:amount, "must be numeric")
    end
  end
end
