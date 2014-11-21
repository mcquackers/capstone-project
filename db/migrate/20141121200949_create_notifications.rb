class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.integer :subject_id, null: false
      t.string :subject_type, null: false

      t.timestamps
    end
    add_index :notifications, :user_id
  end
end
