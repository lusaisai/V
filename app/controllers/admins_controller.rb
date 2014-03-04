class AdminsController < ApplicationController
  ROOT = 'N:/Videos'
  def scan
    Dir.chdir ROOT
    Dir.entries('.').each do |base_dir|
      next if base_dir == '.' || base_dir == '..'
      next unless File.directory? base_dir
      cate = Category.find_or_create_by name: base_dir


      Dir.chdir base_dir do
        Dir.entries('.').each do |name|
          next if name == '.' || name == '..'
          # group of files in a folder
          if File.directory? name
            # group info
            group = Group.find_or_create_by path: File.join(base_dir, name)
            group.name = name
            group.with_image = File.exist? "#{name}/cover.jpg"
            group.save

            Dir.entries(name).each do |video_name|
              next unless is_video(video_name)
              path = File.join( base_dir, name, video_name) # path has suffix
              video_name.sub! /\.[^.]*$/, '' # name has no suffix
              video = Video.find_or_create_by path: path
              video.name = video_name
              video.group = group
              video.with_image = File.exist? "#{name}/#{video_name}.jpg"
              video.with_subtitle = File.exist? "#{name}/#{video_name}.srt"
              video.categories << cate
              video.save
            end
            next
          end
          #single video files
          next unless is_video(name)
          video_name = name
          path = File.join( base_dir, video_name)
          video_name.sub! /\.[^.]*$/, ''
          video = Video.find_or_create_by path: path
          video.name = video_name
          video.with_image = File.exist? "#{video_name}.jpg"
          video.with_subtitle = File.exist? "#{video_name}.srt"
          video.categories << cate
          video.save
        end
      end
    end
  end

  def is_video(name)
    name.downcase.end_with? '.mp4', '.m4v', '.webm'
  end

  def clean
    Video.all.each do |v|
      v.delete unless File.exist? File.join ROOT, v.path
    end
    render nothing: true
  end

end
