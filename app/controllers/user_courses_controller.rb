class UserCoursesController < ApplicationController
  def index
    @user = load_user_from_url
    @user_courses = @user.courses
  end

  private

  def load_user_from_url
    User.find(params[:user_id])
  end
end
