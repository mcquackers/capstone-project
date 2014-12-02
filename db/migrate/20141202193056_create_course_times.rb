class CreateCourseTimes < ActiveRecord::Migration
  def change
    create_table :course_times do |t|
      t.integer :user_id, null: false
      t.integer :course_id, null: false
      t.integer :duration_in_seconds, null: false

      t.timestamps
    end

    add_index :course_times, :user_id
    add_index :course_times, :course_id
  end
end
