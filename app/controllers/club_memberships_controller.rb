class ClubMembershipsController < ApplicationController
  def create
    @club = load_club_from_url
    @club.members << current_user
    @club_membership_entry = ClubMembershipEntry.
      new(user_name: current_user.name, connector_phrase: "joined",
          club_name: @club.name)
    if @club_membership_entry.save
      current_user.feed_updates.create(entry: @club_membership_entry)
    end

    redirect_to [@club.area, @club]
  end

  def destroy
    @club = load_club_from_url
    club_membership = load_club_membership_from_url
    ClubMembership.destroy(club_membership)
    @club_membership_entry = ClubMembershipEntry.
      new(user_name: current_user.name, connector_phrase: "left",
          club_name: @club.name)
    if @club_membership_entry.save
      current_user.feed_updates.create(entry: @club_membership_entry)
    end
    redirect_to [@club.area, @club]
  end

  private

  def load_club_membership_from_url
    ClubMembership.find(params[:id])
  end

  def load_club_from_url
    Club.find(params[:club_id])
  end
end
