class AddStuffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :bike, :string
  end
end
