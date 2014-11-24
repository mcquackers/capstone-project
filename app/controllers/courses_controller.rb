class CoursesController < ApplicationController
  def index
    @area = load_area_from_url
    @courses = @area.courses
  end

  private

  def load_area_from_url
    Area.find(params[:area_id])
  end
end
