class Course < ActiveRecord::Base
  belongs_to :area
  belongs_to :user
  has_many :waypoints, dependent: :destroy
  has_many :course_times, dependent: :destroy

  accepts_nested_attributes_for :waypoints

  def start_point
    waypoints.first
  end

  def end_point
    waypoints.last
  end

  def mid_points
    waypoints[1..-2]
  end

  def top_times
    course_times.order(duration_in_seconds: :asc).limit(10)
  end
end
