class CreateFeedPostSubjects < ActiveRecord::Migration
  def change
    create_table :feed_post_subjects do |t|
      t.integer :user_id, null: false
      t.integer :poster_id, null: false

      t.timestamps
    end
  end
end
