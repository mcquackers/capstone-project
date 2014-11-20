module UserImageHelper
  DEFAULT_IMAGE_URL = "guest_image.png"

  def user_image(user)
    image_or_default(user.avatar_url, DEFAULT_IMAGE_URL, "profile-image")
  end

  def user_thumbnail(user)
    image_or_default(user.avatar_url, DEFAULT_IMAGE_URL, "thumbnail-image")
  end

  private

  def image_or_default(url, default, class_string)
    image_tag (url.presence || default), class: class_string
  end
end
