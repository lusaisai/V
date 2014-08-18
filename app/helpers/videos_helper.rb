module VideosHelper
  PREFIX = 'http://windowsai/videos/'

  def image_url(video)
    if video.with_image
      video.image_url
    elsif video.group && video.group.image_url
      video.group.image_url
    else
      '/assets/cover.jpg'
    end
  end

end
