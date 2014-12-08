class CreateNewTopTimeEntries < ActiveRecord::Migration
  def change
    create_table :new_top_time_entries do |t|
      t.integer :course_time_id, null: false
      t.integer :duration_in_seconds, null: false

      t.timestamps
    end
  end
end
