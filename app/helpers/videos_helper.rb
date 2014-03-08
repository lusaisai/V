module VideosHelper
  PREFIX = 'http://localhost:8080/videos/'

  def image_url(video)
    if video.with_image
      video.image_url
    else
      video.group.image_url
    end
  end

end
