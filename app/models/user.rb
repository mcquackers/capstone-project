class User < ActiveRecord::Base
  has_many :listings
  has_many :notifications
  has_many :feed_updates
  has_many :posts, class_name: "FeedUpdate", foreign_key: :poster_id
  has_many :club_memberships, foreign_key: "member_id"
  has_many :clubs, through: :club_memberships
  has_many :buddy_relationships
  has_many :buddies, through: :buddy_relationships
  has_many :courses
  has_many :course_times
  belongs_to :area

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :area_id, presence: true
  validates :name, presence: true

  def membership_for(club)
    club_memberships.where(club_id: club.id).first
  end

  def buddies
    buddy_ids = BuddyRelationship.
      where(user_id: id, confirmed: true).
      pluck(:buddy_id)
    buddy_ids += BuddyRelationship.
      where(buddy_id: id, confirmed: true).
      pluck(:user_id)
    User.where(id: buddy_ids)
  end

  def pending_buddies
    pending_buddy_ids = BuddyRelationship.pending.
      where(user_id: id).
      pluck(:buddy_id)
    User.where(id: pending_buddy_ids)
  end
end
