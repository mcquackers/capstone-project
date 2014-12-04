class FeedUpdate < ActiveRecord::Base
  belongs_to :user
  belongs_to :poster, class_name: "User"
  belongs_to :entry, polymorphic: true, dependent: :destroy

  validates :user_id, presence: true
  validates :entry, presence: true
end
