class ClubsController < ApplicationController
  def new
    @area = load_area_from_url
    @club = @area.clubs.new
  end

  def create
    @area = load_area_from_url
    @club = @area.clubs.new(new_club_params)
    if @club.save
      @club.members << current_user
      redirect_to [@area, @club]
    end
  end

  def show
    @club = load_club_from_url
  end

  def index
    @area = load_area_from_url
    @paginated_clubs = @area.clubs.page(params[:page]).per(5)
  end

  private

  def load_area_from_url
    Area.find(params[:area_id])
  end

  def load_club_from_url
    Club.find(params[:id])
  end

  def new_club_params
    params.require(:club).
      permit(:name, :location, :image_url, :description).
      merge(admin_id: current_user.id)
  end
end
