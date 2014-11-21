class BuddyRequestSubject < ActiveRecord::Base
  has_one :notification, as: :subject

  validates :requested_id, presence: true
  validates :requester_id, presence: true
end
