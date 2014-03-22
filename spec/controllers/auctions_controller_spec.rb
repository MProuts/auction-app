require 'spec_helper'

describe AuctionsController do

  context "permissions" do
    describe "#create" do

      it 'create a post if the user is logged in' do
        user = create(:user)
        session[:user_id] = user.id
        expect { post :create, { :auction => attributes_for(:auction) }}.
        to change { Auction.all.count }.by(1)
      end

      it "should not create a post if the user is not logged in" do
        post :create, { :auction => attributes_for(:auction) }}.
        to change { Auction.all.count }
        expect(last_response.body).to include("Please sign in")
      end
    end
  end
end
