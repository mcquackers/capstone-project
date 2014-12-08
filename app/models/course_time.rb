class CourseTime < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  delegate :area, to: :user
  delegate :distance, to: :course, prefix: true
  delegate :name, to: :course, prefix: true

  def self.ordered_by_course_and_duration
    order(course_id: :asc, duration_in_seconds: :asc)
  end
end
