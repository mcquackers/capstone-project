class NotificationsController < ApplicationController
  def index
    @user = load_user_from_url
  end

  private

  def load_user_from_url
    User.find(params[:user_id])
  end
end
