class CreateClubMemberships < ActiveRecord::Migration
  def change
    create_table :club_memberships do |t|
      t.integer :member_id, null: false
      t.integer :club_id, null: false

      t.timestamps
    end
    add_index :club_memberships, [:member_id, :club_id]
  end
end
