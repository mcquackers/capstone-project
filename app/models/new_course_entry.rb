class NewCourseEntry < ActiveRecord::Base
  has_one :feed_update, as: :entry
  belongs_to :course

  delegate :area, :name, :description, to: :course

  validates :course_id, presence: true
end
