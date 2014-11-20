module StatusEntryImageHelper
  def status_image(url)
    if url.present?
      image_tag url, class: "status-entry-image"
    end
  end
end
