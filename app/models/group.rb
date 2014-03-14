class Group < ActiveRecord::Base
  has_many :videos

  def image_path
    path + '/cover.jpg'
  end

  def image_url
    URI.escape( Video::URL_PREFIX + image_path )
  end

end
