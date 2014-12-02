class CreateNewCourseEntries < ActiveRecord::Migration
  def change
    create_table :new_course_entries do |t|
      t.integer :course_id, null: false

      t.timestamps
    end
    add_index :new_course_entries, :course_id
  end
end
