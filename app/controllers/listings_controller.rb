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
    @listings = Listing.where(filter_params).where(filter_price).
      where(filter_title)
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

  def filter_params
    if params[:filter]
      params.require(:filter).permit(:category, :area_id).
        select { |_key, value| value.present? }
    else
      { area_id: current_user.area.id }
    end
  end

  def filter_title
    if params[:filter] && params[:filter][:title].present?
      ["title ILIKE ?", "%#{params[:filter][:title]}%"]
    else
      {}
    end
  end

  def filter_price
    if params[:filter] && params[:filter][:low_price].present? &&
        params[:filter][:high_price].present?
      ["price BETWEEN ? AND ?",
       params[:filter][:low_price], params[:filter][:high_price]]
    else
      {}
    end
  end
end
