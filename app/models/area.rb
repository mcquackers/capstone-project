class Area < ActiveRecord::Base
  has_many :listings
  has_many :users
  has_many :clubs
  has_many :courses
end
