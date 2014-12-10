class ClubFeedPost < ActiveRecord::Base
  belongs_to :club
  belongs_to :poster, class_name: "User"

  validates :body, presence: true

  delegate :name, to: :poster, prefix: true
end
