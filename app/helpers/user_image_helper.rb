module UserImageHelper
  DEFAULT_IMAGE_URL = "guest_image.png"

  def user_image(user)
    image_tag image_or_default(user), class: "profile-image"
  end

  def user_thumbnail(user)
    image_tag image_or_default(user), class: "thumbnail-image"
  end

  private

  def image_or_default(user)
    user.avatar_url.presence || DEFAULT_IMAGE_URL
  end
end
