class User < ActiveRecord::Base
  has_many :listings
  has_many :feed_updates
  belongs_to :area

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :area_id, presence: true
  validates :name, presence: true
end
