class BidsController < ApplicationController
  before_action :set_auction
  def new
    @bid = Bid.new
  end

  def create
    @bid = Bid.new(bid_params)
    @bid.auction_id = @auction.id
    if @bid.save
      redirect_to @auction, :notice => "You successfully submitted a bid!"
    else
      render :new 
    end
  end

  def show
  end

  private
  def bid_params
    params.require(:bid).permit(:amount)
  end

  def set_auction
    @auction = Auction.find(params[:auction_id])
  end
end
