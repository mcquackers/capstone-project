class CreateStatusEntries < ActiveRecord::Migration
  def change
    create_table :status_entries do |t|
      t.string :image_url
      t.string :body

      t.timestamps
    end
  end
end
