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
    @listings = Listing.where(filter_area_and_category).
      where(search_title).
      where(search_price)
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

  def filter_area_and_category
    if searched?
      params.require(:search).
        permit(:area_id, :category).
        select { |_key, value| value.present? }
    else
      { area_id: current_user.area.id }
    end
  end

  def search_params
    params.require(:search).
      permit(:area_id, :category, :low_price,
                                  :high_price, :title).
      select { |_key, value| value.present? }
  end

  def search_title
    if searched?
      ["title ILIKE ?", "%#{search_params[:title]}%"]
    end
  end

  def search_price
    if searched? && price_range_defined?
      ["price BETWEEN ? AND ?", search_params[:low_price],
       search_params[:high_price]]
    end
  end

  def price_range_defined?
    search_params.keys.include?("low_price") &&
      search_params.keys.include?("high_price")
  end

  def searched?
    !!params[:search]
  end
end
