class CreateClubMembershipEntries < ActiveRecord::Migration
  def change
    create_table :club_membership_entries do |t|
      t.string :user_name, null: false
      t.string :club_name, null: false
      t.string :connector_phrase, null: false

      t.timestamps
    end
  end
end
