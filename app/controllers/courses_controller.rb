class CoursesController < ApplicationController
  def new
    @area = load_area_from_url
    @course = Course.new
  end

  def create
    @area = load_area_from_url
    @course = @area.courses.new(course_params)
    if @course.save
      redirect_to area_courses_path(@area)
    else
      redirect_to root_path
    end
  end

  def index
    @area = load_area_from_url
    @courses = @area.courses
  end

  private

  def course_params
    params.
      require(:course).
      permit(
        :name,
        :distance,
        start_point_attributes: [:lat, :lng],
        end_point_attributes: [:lat, :lng]
      ).
      merge(user_id: current_user.id, image_url: "")
  end

  def load_area_from_url
    Area.find(params[:area_id])
  end
end
