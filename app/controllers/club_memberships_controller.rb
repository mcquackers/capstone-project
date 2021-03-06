class ClubMembershipsController < ApplicationController
  def create
    @club = load_club_from_url
    @club.members << current_user
    @club_membership_entry = ClubMembershipEntry.new(
      user_name: current_user.name, connector_phrase: "joined",
      club_name: @club.name)
    if @club_membership_entry.save
      create_feed_update(@club_membership_entry, current_user.id)
    end

    redirect_to [@club.area, @club]
  end

  def destroy
    @club = load_club_from_url
    club_membership = load_club_membership_from_url
    ClubMembership.destroy(club_membership)
    @club_membership_entry = ClubMembershipEntry.new(
      user_name: current_user.name, connector_phrase: "left",
      club_name: @club.name)
    if @club_membership_entry.save
      create_feed_update(@club_membership_entry, current_user.id)
    end

    redirect_to [@club.area, @club]
  end

  private

  def create_feed_update(entry, poster_id)
    current_user.feed_updates.create(
      entry: entry,
      poster_id: poster_id
    )
  end

  def load_club_membership_from_url
    ClubMembership.find(params[:id])
  end

  def load_club_from_url
    Club.find(params[:club_id])
  end
end
