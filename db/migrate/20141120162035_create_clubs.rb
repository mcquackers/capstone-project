class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.integer :area_id, null: false
      t.string :name, null: false
      t.string :image_url
      t.string :location, null: false
      t.text :description, null: false
      t.integer :admin_id, null: false

      t.timestamps
    end
  end
end
