class Group < ActiveRecord::Base
  has_many :videos

  def image_path
    path + '/cover.jpg'
  end
end
