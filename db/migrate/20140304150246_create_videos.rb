class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.boolean :with_image
      t.boolean :with_subtitle
      t.integer :group_id
      t.string :path

      t.timestamps
    end
  end
end
