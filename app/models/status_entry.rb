class StatusEntry < ActiveRecord::Base
  has_one :feed_update, as: :entry

  validates :body, presence: true
end
