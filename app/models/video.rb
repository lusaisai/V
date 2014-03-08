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

  def image_url
    URI.escape( URL_PREFIX + image_path )
  end

  def subtitle_url
    URI.escape( '/videos/subtitle/' + id.to_s )
  end

  def file
   FILE_PREFIX + path
  end

  def image_file
    FILE_PREFIX + image_path
  end

  def subtitle_file
    FILE_PREFIX + subtitle_path
  end

  def set_width_height
    self.width= 1280 #default values
    self.height= 720
    command = '"D:\software\ffmpeg\bin\ffprobe.exe" -show_streams -i ' + "\"#{file.encode 'cp936'}\""
    data = `#{command}`.split "\n"
    data.each do |s|
      if s.start_with? 'width='
        self.width= s.sub('width=', '')
      end
      if s.start_with? 'height='
        self.height= s.sub('height=', '')
        return
      end
    end
  end

  def ass2srt
    ass_file = FILE_PREFIX + path.sub(/\.[^.]*$/, '') + '.ass'
    return unless File.exist? ass_file

    srt_file = File.open( subtitle_file, 'w' )
    index = -2
    File.open(ass_file, 'r').each_line do |line|
      index = -1 if line.start_with? '[Events]'
      next if index < -1
      if index > 0
        begin
        data = line.split ','
        start_time = '0' + data[1].sub('.', ',') + '0'
        end_time = '0' + data[2].sub('.', ',') + '0'
        text = data[-1]
        srt_file.write index.to_s + "\n"
        srt_file.write start_time + ' --> ' + end_time + "\n"
        srt_file.write text + "\n"
        rescue Exception
        end
      end
      index += 1
    end
    srt_file.close

  end


end
