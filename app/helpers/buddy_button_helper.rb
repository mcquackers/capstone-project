module BuddyButtonHelper
  def buddy_button(user)
    if current_user.buddies.include?(user)
      ditch_button(user)
    elsif current_user.pending_buddies.include?(user)
      pending_button
    elsif user.pending_buddies.include?(current_user)
      accept_buddy_button(user)
    else
      add_buddy_button(user)
    end
  end

  private

  def buddy_relationship(user)
    BuddyRelationship.for(user.id, current_user.id)
  end

  def pending_button
    button_to "Buddy Request Pending", {}, disabled: true
  end

  def ditch_button(user)
    button_to "Ditch this buddy",
      [user, buddy_relationship(user)], method: :delete
  end

  def accept_buddy_button(user)
    button_to "Accept Buddy Request",
      [user, buddy_relationship(user), confirmed: true], method: :patch
  end

  def add_buddy_button(user)
    button_to "Send Buddy Request",
      user_buddy_relationships_path(user)
  end
end
