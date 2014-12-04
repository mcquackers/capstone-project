class AddPosterIdToFeedUpdates < ActiveRecord::Migration
  def change
    add_column :feed_updates, :poster_id, :integer, null: false
    add_index :feed_updates, :poster_id
  end
end
