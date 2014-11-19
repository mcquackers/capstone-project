class CreateFeedUpdates < ActiveRecord::Migration
  def change
    create_table :feed_updates do |t|
      t.integer :user_id, null: false
      t.integer :entry_id, null: false
      t.string :entry_type

      t.timestamps
    end
    add_index :feed_updates, :user_id
  end
end
