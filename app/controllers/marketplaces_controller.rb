class MarketplacesController < ApplicationController
  def show
    @area = Area.find(params[:area_id])
    @listings = Listing.all
  end
end
