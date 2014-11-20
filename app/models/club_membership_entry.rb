class ClubMembershipEntry < ActiveRecord::Base
  has_one :feed_update, as: :entry
end
