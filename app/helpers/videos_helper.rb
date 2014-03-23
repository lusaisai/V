module VideosHelper
  PREFIX = 'http://localhost/videos/'

  def image_url(video)
    if video.with_image
      video.image_url
    else
      video.group.image_url
    end
  end

end
