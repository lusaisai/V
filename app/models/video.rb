require 'uri'
class Video < ActiveRecord::Base
  has_and_belongs_to_many :categories
  belongs_to :group
  URL_PREFIX = 'http://localhost:8080/videos/'
  FILE_PREFIX = 'N:/Videos/'

  def image_path
    path.sub(/\.[^.]*$/, '') + '.jpg'
  end

  def subtitle_path
    path.sub(/\.[^.]*$/, '') + '.srt'
  end

  def url
    URI.escape( URL_PREFIX + path )
  end

  def url_image
    URI.escape( URL_PREFIX + image_path )
  end

  def url_subtitle
    URI.escape( '/videos/subtitle/' + id.to_s )
  end

  def file
   FILE_PREFIX + path
  end

  def file_image
    FILE_PREFIX + image_path
  end

  def file_subtitle
    FILE_PREFIX + subtitle_path
  end

  def set_width_height
    self.width= 1280 #default values
    self.height= 720
    command = '"D:\software\ffmpeg\bin\ffprobe.exe" -show_streams -i ' + "\"#{file}\""
    data = `#{command}`.split /[\r\n]+/
    data.each do |s|
      if s.start_with? 'width='
        self.width= s.sub('width=', '')
      end
      if s.start_with? 'height='
        self.height= s.sub('height=', '')
      end
    end
  end


end
