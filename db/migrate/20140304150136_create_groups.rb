class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :with_image
      t.string :path

      t.timestamps
    end
  end
end
