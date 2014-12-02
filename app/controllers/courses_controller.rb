class CoursesController < ApplicationController
  def new
    @area = load_area_from_url
    @course = Course.new
  end

  def create
    @area = load_area_from_url
    @course = @area.courses.new(course_params)
    if @course.save
      course_entry = NewCourseEntry.create(course_id: @course.id)
      current_user.feed_updates.create(entry: course_entry)
      redirect_to area_courses_path(@area)
    else
      redirect_to root_path
    end
  end

  def index
    @area = load_area_from_url
    @courses = @area.courses
  end

  def show
    @area = load_area_from_url
    @course = load_course_from_url
    @course_time = @course.course_times.new
    respond_to do |format|
      format.html { render :show }
      format.json do
        render json: {
          start_point: @course.start_point,
          end_point: @course.end_point,
          mid_points: @course.mid_points
        }
      end
    end
  end

  private

  def course_params
    params.
      require(:course).
      permit(
        :name,
        :distance,
        :description,
        waypoints_attributes: [:lat, :lng, :order]
      ).
      merge(user_id: current_user.id)
  end

  def load_area_from_url
    Area.find(params[:area_id])
  end

  def load_course_from_url
    Course.find(params[:id])
  end
end
