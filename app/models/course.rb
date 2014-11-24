class Course < ActiveRecord::Base
  belongs_to :user
  belongs_to :area
  belongs_to :course_data, polymorphic: true, dependent: :destroy

  def creator
    if user_id.present?
      creator = User.find(user_id)
      link_to creator.name, creator
    else
      Area.find(area_id).name
    end
  end
end
