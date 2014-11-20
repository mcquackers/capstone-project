class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.integer :area_id
      t.string :name
      t.string :image_url
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
