class BuddyRelationshipsController < ApplicationController
  def create
    buddy = load_buddy_from_url
    buddy_request = current_user.buddy_relationships.new(buddy_id: buddy.id)
    if buddy_request.save
      create_buddy_request_notification(buddy)
      redirect_to buddy
    end
  end

  def update
    buddy = load_buddy_from_url
    buddy_relationship = BuddyRelationship.for(current_user.id, buddy.id)
    buddy_relationship.update(confirmed: params[:confirmed])

    redirect_to buddy
  end

  def destroy
    buddy = load_buddy_from_url
    BuddyRelationship.for(current_user.id, buddy.id).destroy

    redirect_to buddy
  end

  private

  def load_buddy_from_url
    User.find(params[:user_id])
  end

  def create_buddy_request_notification(buddy)
    buddy_request = BuddyRequestSubject.new(
      requester_name: current_user.name,
      requester_id: current_user.id,
      requested_id: buddy.id
    )
    if buddy_request.save
      buddy.notifications.create(subject: buddy_request)
    end
  end
end
