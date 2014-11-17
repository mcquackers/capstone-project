class AddAreaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :area_id, :integer, null: false, default: 1
  end
end
