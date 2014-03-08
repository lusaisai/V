class Group < ActiveRecord::Base
  has_many :videos
  URL_PREFIX = 'http://localhost:8080/videos/'

  def image_path
    path + '/cover.jpg'
  end

  def image_url
    URI.escape( URL_PREFIX + image_path )
  end

end
