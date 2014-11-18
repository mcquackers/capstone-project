class MarketplacesController < ApplicationController
  def show
    @user = load_user_from_url
    @listings = @user.listings
  end

  private

  def load_user_from_url
    User.find(params[:user_id])
  end
end
