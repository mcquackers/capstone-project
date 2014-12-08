class NewTopTimeEntry < ActiveRecord::Base
  has_one :feed_update, as: :entry
  belongs_to :course_time

  delegate :course_name, to: :course_time
  delegate :course_area, to: :course_time
  delegate :course, to: :course_time
end
