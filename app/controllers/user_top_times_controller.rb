class UserTopTimesController < ApplicationController
  def index
    @user = load_user_from_url
    @user_top_times = @user.top_times
  end

  private

  def load_user_from_url
    User.find(params[:user_id])
  end
end
