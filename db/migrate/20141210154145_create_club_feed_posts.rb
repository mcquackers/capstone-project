class CreateClubFeedPosts < ActiveRecord::Migration
  def change
    create_table :club_feed_posts do |t|
      t.integer :club_id, null: false
      t.integer :poster_id, null: false
      t.string :body, null: false

      t.timestamps
    end

    add_index :club_feed_posts, :club_id
  end
end
