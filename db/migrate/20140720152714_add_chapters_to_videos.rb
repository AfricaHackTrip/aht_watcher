class AddChaptersToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :chapters, :string, array: true, default: '{}'
  end
end
