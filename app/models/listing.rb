class Listing < ActiveRecord::Base
  belongs_to :area
  belongs_to :user

  validates :title, presence: true
  validates :category, presence: true
end
