class CreateBuddyRelationships < ActiveRecord::Migration
  def change
    create_table :buddy_relationships do |t|
      t.integer :user_id, null: false
      t.integer :buddy_id, null: false
      t.boolean :confirmed, null: false, default: false

      t.timestamps
    end

    add_index :buddy_relationships, :user_id
    add_index :buddy_relationships, [:user_id, :buddy_id], unique: true
  end
end
