class AddOrderToWaypoints < ActiveRecord::Migration
  def change
    add_column :waypoints, :order, :integer, null: false
    add_index :waypoints, :order
  end
end
