module ClubHelper
  DEFAULT_IMAGE_URL = "default_club_image.jpg"

  def club_listing_image(image_url)
    # image_tag image_or_default(image_url), class: "club-listing-image"
    image_or_default(image_url, DEFAULT_IMAGE_URL, "club-listing-image")
  end
end
