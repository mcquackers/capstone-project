class ListingsController < ApplicationController
  def new
    @area = Area.find(params[:area_id])
    @listing = @area.listings.new
  end

  def create
    @area = Area.find(params[:area_id])
    @listing = @area.listings.new(listing_params)
    if @listing.save
      redirect_to area_listing_path(@area, @listing)
    else
      render :new
    end
  end

  def index
    @area = Area.find(params[:area_id])
    if searched?
      @paginated_listings = ListingSearcher.new(params, @area.id).search
    else
      @paginated_listings = @area.listings.page(params[:page]).per(10)
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    listing = Listing.find(params[:id])
    listing.update(listing_params)
    redirect_to area_listing_path(listing.area, listing)
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def destroy
    listing = Listing.find(params[:id])
    listing.destroy
    redirect_to area_listings_path(listing.area)
  end

  private

  def listing_params
    params.require(:listing).
      permit(:title, :description, :category, :price, :image_url).
      merge(user_id: current_user.id)
  end

  def searched?
    !!params[:search]
  end
end
