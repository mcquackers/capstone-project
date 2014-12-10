class Club < ActiveRecord::Base
  belongs_to :area
  has_many :club_feed_posts
  has_many :club_memberships
  has_many :members, through: :club_memberships

  def user_sample
    members.sample(6)
  end
end
