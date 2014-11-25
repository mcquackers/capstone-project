class Course < ActiveRecord::Base
  belongs_to :area
  belongs_to :user
  has_one :start_point, class_name: "Waypoint"
  has_one :end_point, class_name: "Waypoint"

  accepts_nested_attributes_for :start_point
  accepts_nested_attributes_for :end_point
end
