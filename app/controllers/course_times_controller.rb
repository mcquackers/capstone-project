class CourseTimesController < ApplicationController
  def create
    @course = load_course_from_url
    @course_time = @course.course_times.new(course_time_params)
    if @course_time.save
      handle_if_new_top_time(@course_time)
      redirect_to course_course_times_path
    end
  end

  def index
    @course = load_course_from_url
    @course_times = @course.course_times.order(duration_in_seconds: :asc)
  end

  private

  def load_course_from_url
    Course.find(params[:course_id])
  end

  def handle_if_new_top_time(course_time)
    if current_user.top_time(course_time.course_id) == course_time
      new_top_time_entry = create_new_top_time_entry(course_time)
      create_new_feed_update(new_top_time_entry)
    end
  end

  def create_new_feed_update(entry)
    current_user.feed_updates.create(
      entry: entry,
      poster_id: current_user.id
    )
  end

  def create_new_top_time_entry(course_time)
    NewTopTimeEntry.create(
      course_time_id: course_time.id,
      duration_in_seconds: course_time.duration_in_seconds
    )
  end

  def course_time_params
    duration = turn_time_to_seconds
    { user_id: current_user.id, duration_in_seconds: duration }
  end

  def turn_time_to_seconds
    time = params[:course_time][:duration_in_seconds]
    hours, minutes, seconds = time.split(":").map(&:to_i)
    (hours * 3600) + (minutes * 60) + seconds
  end
end
