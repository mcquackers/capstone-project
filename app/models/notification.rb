class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, polymorphic: true, dependent: :destroy

  validates :user, presence: true
  validates :subject, presence: true
end
