class ListingSearcher
  def initialize(params_hash, area_id)
    @params = params_hash
    @area_id = area_id
  end

  def search
    @paginated_listings = Listing.where(filter_area_and_category).
      where(search_title).
      where(search_price).
      page(@params[:page]).
      per(10)
  end

  private

  def filter_area_and_category
    @params.require(:search).
      permit(:area_id, :category).
      select { |_key, value| value.present? }
  end

  def search_params
    @params.require(:search).
      permit(:area_id, :category, :low_price,
             :high_price, :title).
             select { |_key, value| value.present? }
  end

  def search_title
    ["title ILIKE ?", "%#{search_params[:title]}%"]
  end

  def search_price
    if price_range_defined?
      ["price BETWEEN ? AND ?", search_params[:low_price],
       search_params[:high_price]]
    end
  end

  def price_range_defined?
    search_params.keys.include?("low_price") &&
      search_params.keys.include?("high_price")
  end
end
