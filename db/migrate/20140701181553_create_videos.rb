class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.timestamps
      t.string :filename
      t.text :description
      t.string :category
      t.integer :rating
    end
  end
end
