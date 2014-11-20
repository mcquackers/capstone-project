class ClubsController < ApplicationController
  def index
    @area = load_area_from_url
    @clubs = @area.clubs
  end

  private

  def load_area_from_url
    Area.find(params[:area_id])
  end
end
