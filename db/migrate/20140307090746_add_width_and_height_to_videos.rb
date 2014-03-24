class AddWidthAndHeightToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :width, :integer
    add_column :videos, :height, :integer
  end
end
