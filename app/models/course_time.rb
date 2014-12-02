class CourseTime < ActiveRecord::Base
  belongs_to :course
  belongs_to :user

  delegate :area, to: :user
end
