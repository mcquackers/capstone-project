class User < ActiveRecord::Base
  has_many :listings
  belongs_to :area

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
