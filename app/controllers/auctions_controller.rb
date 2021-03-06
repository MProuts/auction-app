class AuctionsController < ApplicationController
  before_action :set_auction, :only => [:show, :edit, :update, :destroy]
  before_action :require_login, :only => [:create, :new]
  before_action :authenticate_seller, :only => [:edit, :update, :destroy]

  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new(auction_params)
    @auction.seller_id = current_user.id
    if @auction.save
      redirect_to auctions_path, :notice => "Auction successfully created"
    else
      render :new
    end
  end

  def show
    @current_bid = @auction.current_bid
    @bid = Bid.new
  end

  def edit
  end
  
  def update
    if @auction.update(auction_params)
      redirect_to auctions_path, :notice => "Auction successfully updated"
    else
      render :edit
    end
  end

  def destroy
    unless logged_in_with_id? @auction.seller_id
      redirect_to auctions_path
    else
      @auction.destroy
      redirect_to auctions_path
    end
  end

  private
  def auction_params
    params.require(:auction).permit(:title, :description, :end_time)
  end

  def set_auction
    @auction = Auction.find(params[:id])
  end

  def authenticate_seller
    if !logged_in_with_id? @auction.seller_id
      redirect_to auctions_path, :notice => "You may not edit another user's listing." 
    end
  end
end
