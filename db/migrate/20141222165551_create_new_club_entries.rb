class CreateNewClubEntries < ActiveRecord::Migration
  def change
    create_table :new_club_entries do |t|
      t.integer :user_id, null: false
      t.integer :club_id, null: false

      t.timestamps null: false
    end
  end
end
