class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :area_id, null: false
      t.string :title, null: false
      t.integer :user_id, null: false
      t.string :category, null: false
      t.string :image_url, null: false
      t.integer :price, null: false, default: 1

      t.timestamps
    end
  end
end
