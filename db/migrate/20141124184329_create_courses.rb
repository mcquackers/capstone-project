class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :area_id, null: false
      t.integer :user_id
      t.string :name, null: false
      t.float :distance, null: false
      t.integer :course_data_id, null: false
      t.string :course_data_type, null: false

      t.timestamps null: false
    end

    add_index :courses, :user_id
    add_index :courses, :area_id
  end
end
