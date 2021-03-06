class ApplicationController < ActionController::Base
  include Monban::ControllerHelpers
  protect_from_forgery with: :exception
  before_action :require_login, except: [:index, :show]

  def current_user
    super || Guest.new
  end
end
