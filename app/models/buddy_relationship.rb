class BuddyRelationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :buddy, class_name: "User"

  validate :user_cannot_buddy_self

  def self.for(possible_user_id, possible_buddy_id)
    user_ids = [possible_user_id, possible_buddy_id]
    BuddyRelationship.find_by(user_id: user_ids, buddy_id: user_ids)
  end

  def self.pending
    BuddyRelationship.where(confirmed: false)
  end

  private

  def user_cannot_buddy_self
    if user_id == buddy_id
      errors.add(:base, "You can't add yourself as a buddy")
    end
  end
end
