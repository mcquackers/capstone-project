class StatusEntriesController < ApplicationController
  def create
    @user = load_user_from_url
    @status_entry = StatusEntry.new(status_entry_params)
    if @status_entry.save
      @user.feed_updates.create(feed_update_params(@status_entry))
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
end
