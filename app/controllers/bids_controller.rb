class BidsController < ApplicationController
  before_action :set_auction
  before_action :require_login
  before_action :authenticate_bidder

  def create
    @bid = Bid.new(bid_params)
    @bid.auction_id = @auction.id
    @bid.bidder_id = current_user.id if current_user
    if @bid.save
      redirect_to @auction, :notice => "You successfully submitted a bid!"
    else
      render 'auctions/show' 
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:amount_in_dollars)
  end

  def set_auction
    @auction = Auction.find(params[:auction_id])
  end

  def authenticate_bidder
    if logged_in_with_id? @auction.seller.id
      flash.now[:notice] = "You may not bid on your own items."
      @bid = Bid.new
      render 'auctions/show'
    end
  end

end
