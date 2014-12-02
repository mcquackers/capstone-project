module DurationHelper
  def duration_in_hms_format(duration)
    seconds = duration % 60
    minutes = (duration / 60) % 60
    hours = duration / 3600

    format("%02d:%02d:%02d", hours, minutes, seconds)
  end
end
