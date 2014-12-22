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
      handle_new_club_feed_post(@club)
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

  def handle_new_club_feed_post(club)
    new_club_entry = create_new_club_entry(club)
    create_new_club_feed_post(new_club_entry)
  end

  def create_new_club_feed_post(new_club_entry)
    current_user.feed_updates.create(
      entry: new_club_entry,
      poster_id: current_user.id
    )
  end

  def create_new_club_entry(club)
    NewClubEntry.create(
      user_id: current_user.id,
      club_id: club.id
    )
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
