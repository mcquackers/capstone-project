class CoursesController < ApplicationController
  def new
    @area = load_area_from_url
    @course = Course.new
  end

  def index
    @area = load_area_from_url
    @courses = @area.courses
  end

  private

  def load_area_from_url
    Area.find(params[:area_id])
  end
end
