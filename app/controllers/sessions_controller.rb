class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(:email => params[:email])
    if @user && @user.authenticate(params[:password])
      log_in @user
      redirect_to auctions_path
    else
      flash.now[:notice] = "Password and email don't match."
      @user = User.new
      render 'sessions/new'
    end
  end

  def destroy
    log_out!
    redirect_to auctions_path
  end
end
