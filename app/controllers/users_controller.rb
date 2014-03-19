class UsersController < ApplicationController
  before_action :set_user, :only => [:edit, :update, :destroy]
  def new
    @user = User.new
  end

  #login user
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to auctions_path
    else
      render :new
    end
  end

  #require login
  def edit

  end

  #require login
  def update
    if @user.update(user_params)
      redirect_to auctions_path
    else
      render :edit
    end
  end

  #require login
  def destroy
    @user.destroy
    redirect_to auctions_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
