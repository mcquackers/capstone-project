class MarketplacesController < ApplicationController
  def show
    @listings = Listing.all
  end
end
