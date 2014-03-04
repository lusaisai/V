module VideosHelper
  PREFIX = 'http://localhost:8080/videos/'

  def image_url(video)
    PREFIX + video.image_path
  end

  def subtitle_url(video)
    PREFIX + video.subtitle_path
  end
end
