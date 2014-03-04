class CreateCategoriesVideos < ActiveRecord::Migration
  def change
    create_join_table :categories, :videos
  end
end
