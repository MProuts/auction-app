require 'spec_helper'

describe BidsController do
  describe "validations" do

    before(:each) do
      @bidder = create(:user)
      @seller = create(:user)
      @auction = create(:auction, :seller_id => @seller.id)
    end

    it "can't place bid if not logged in" do
      bid_count = Bid.count

      post :create, { :auction_id => @auction.id, :bid => { 
                                :bidder_id => @bidder.id,
                                :amount => 1000 }}
      expect(Bid.count).to eq(bid_count)
      expect(response).to redirect_to(log_in_path)
    end

    it "seller can't bid on own items" do
      bid_count = Bid.count
      log_in @seller
      post :create, { :auction_id => @auction.id, :bid => { 
                                :bidder_id => @seller.id,
                                :amount => 1000 }}
      expect(Bid.count).to eq(bid_count)
    end

    it "logged in user can bid on other user's items" do
      bid_count = Bid.count
      log_in @bidder
      post :create, { :auction_id => @auction.id, :bid => { 
                                :bidder_id => @bidder.id,
                                :amount => 1000 }}
      expect(Bid.count).to eq(bid_count + 1)
    end
  end
end

