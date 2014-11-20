class User < ActiveRecord::Base
  has_many :listings
  has_many :feed_updates
  has_many :club_memberships, foreign_key: "member_id"
  has_many :clubs, through: :club_memberships
  belongs_to :area

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :area_id, presence: true
  validates :name, presence: true

  def membership_for(club)
    club_memberships.where(club_id: club.id).first
  end
end
