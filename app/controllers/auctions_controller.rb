class AuctionsController < ApplicationController
  before_action :set_auction, :only => [:show, :edit, :update, :destroy]
  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new(auction_params)
    if @auction.save
      redirect_to auctions_path, :notice => "Auction successfully created"
    else
      render :new
    end
  end

  def show
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
    @auction.destroy
    redirect_to auctions_path
  end

  private
  def auction_params
    params.require(:auction).permit(:title, :description, :end_time)
  end

  def set_auction
    @auction = Auction.find(params[:id])
  end
end
