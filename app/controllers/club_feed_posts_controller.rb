class ClubFeedPostsController < ApplicationController
  def create
    club = load_club_from_url
    feed_post = club.club_feed_posts.new(feed_post_params)
    feed_post.save

    redirect_to [club.area, club]
  end

  private

  def load_club_from_url
    Club.find(params[:club_id])
  end

  def feed_post_params
    params.require(:club_feed_post).permit(:body, :poster_id)
  end
end
