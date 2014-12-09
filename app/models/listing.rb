class Listing < ActiveRecord::Base
  CATEGORIES = ["Full Bikes", "Frames", "Locomotion Assembly", "Wheel Assembly",
                "Brake Assembly", "Shifter Assembly", "Protection", "Clothing",
                "Accessories", "Miscellaneous"]
  belongs_to :area
  belongs_to :user

  delegate :name, to: :user, prefix: true

  validates :title, presence: true
  validate :valid_category

  private

  def valid_category
    unless CATEGORIES.include?(category)
      errors.add(:category,
                 "Category must be one of the predefined categories")
    end
  end
end
