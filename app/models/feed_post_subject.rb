class FeedPostSubject < ActiveRecord::Base
  has_one :notification, as: :subject
  belongs_to :poster, class_name: "User"

  delegate :name, to: :poster, prefix: true

  validates :user_id, :poster_id, presence: true
end
