module ListingFormHelper
  def listing_form_url(listing)
    if listing.persisted?
      area_marketplace_listing_path(listing.area, listing)
    else
      area_marketplace_listings_path(listing.area)
    end
  end
end
