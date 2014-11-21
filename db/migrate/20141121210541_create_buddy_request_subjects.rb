class CreateBuddyRequestSubjects < ActiveRecord::Migration
  def change
    create_table :buddy_request_subjects do |t|
      t.string :requester_name, null: false
      t.integer :requester_id, null: false
      t.integer :requested_id, null: false

      t.timestamps
    end
  end
end
