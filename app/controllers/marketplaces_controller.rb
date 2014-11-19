class MarketplacesController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @listings = @user.listings
  end
end
