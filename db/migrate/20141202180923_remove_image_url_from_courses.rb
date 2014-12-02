class RemoveImageUrlFromCourses < ActiveRecord::Migration
  def up
    remove_column :courses, :image_url
  end

  def down
    add_column :courses, :image_url, :string, null: false
  end
end
