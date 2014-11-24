class ClubListsController < ApplicationController
  def show
    user = load_user_from_url
    @clubs = user.clubs
  end

  private

  def load_user_from_url
    User.find(params[:user_id])
  end
end
