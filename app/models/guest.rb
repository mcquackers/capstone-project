class Guest
  def name
    "Guest"
  end

  def email
    "Guest"
  end

  def area_id
    1
  end

  def area
    Area.first
  end

  def id
    nil
  end

  def buddies
    []
  end

  def pending_buddies
    []
  end
end
