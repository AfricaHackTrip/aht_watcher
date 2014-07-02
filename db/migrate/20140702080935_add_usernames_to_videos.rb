class AddUsernamesToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :username, :string
  end
end
