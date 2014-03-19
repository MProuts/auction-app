class SessionsController < ApplicationController
  def create
    @user = User.find_by(:email => params[:email])
    binding.pry
  end

  def destroy
  end
end
