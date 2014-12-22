class NewClubEntry < ActiveRecord::Base
  has_one :feed_update, as: :entry

  belongs_to :club
  belongs_to :user

  delegate :name, to: :user, prefix: true
  delegate :name, to: :club, prefix: true
end
