class NotificationsController < ApplicationController
  def index
    @user = load_user_from_url
  end

  def destroy
    user = load_user_from_url
    notification = load_notification_from_url
    notification.destroy
    redirect_to user_notifications_path(user)
  end

  private

  def load_user_from_url
    User.find(params[:user_id])
  end

  def load_notification_from_url
    Notification.find(params[:id])
  end
end
