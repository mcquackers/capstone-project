class Club < ActiveRecord::Base
  belongs_to :area
  has_many :club_memberships
  has_many :members, through: :club_memberships
end
