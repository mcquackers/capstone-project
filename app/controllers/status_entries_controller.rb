class StatusEntriesController < ApplicationController
  before_action :require_buddy, only: [:create]
  def create
    @user = load_user_from_url
    @status_entry = StatusEntry.new(status_entry_params)
    if @status_entry.save
      @user.feed_updates.create(feed_update_params(@status_entry))
      send_notification(@user)
      redirect_to @user
    end
  end

  private

  def status_entry_params
    params.require(:status_entry).permit(:image_url, :body)
  end

  def load_user_from_url
    User.find(params[:user_id])
  end

  def feed_update_params(status_entry)
    { entry: status_entry, poster_id: current_user.id }
  end

  def send_notification(user)
    unless user == current_user
      feed_post_subject = FeedPostSubject.new(
        user_id: user.id,
        poster_id: current_user.id
      )
      if feed_post_subject.save
        user.notifications.create(subject: feed_post_subject)
      end
    end
  end

  def require_buddy
    user = load_user_from_url
    unless user == current_user || user.buddies.include?(current_user)
      redirect_to user, flash: { error: "You must be buddies" }
    end
  end
end
