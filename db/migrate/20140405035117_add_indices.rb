class AddIndices < ActiveRecord::Migration
  def change
    add_index :videos, :group_id
    add_index :categories_videos, :category_id
    add_index :categories_videos, :video_id
  end
end
