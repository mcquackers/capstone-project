class StatusEntriesController < ApplicationController
  def create
    @status_entry = StatusEntry.new(status_entry_params)
    if @status_entry.save
      current_user.feed_updates.create(entry: @status_entry)
      redirect_to current_user
    end
  end

  private

  def status_entry_params
    params.require(:status_entry).permit(:image_url, :body)
  end
end
