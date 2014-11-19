module UserImageHelper
  DEFAULT_IMAGE_URL = "guest_image.png"
  def user_image(user)
    user.avatar_url.presence || DEFAULT_IMAGE_URL
  end
end
