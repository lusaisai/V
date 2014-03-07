class AdminController < ApplicationController
  ROOT = 'N:/Videos'

  def index
  end

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
              save_video File.join( base_dir, name, video_name), cate, group
            end
            next
          end
          #single video files
          save_video File.join( base_dir, name), cate, nil
        end
      end
    end

    respond_to do |format|
      format.js {}
    end
  end

  def save_video( path, category, group )
    return unless is_video(path)
    video = Video.find_or_create_by path: path
    video.name = File.basename(path).sub /\.[^.]*$/, ''
    video.with_image = File.exist? video.file_image
    video.with_subtitle = File.exist? video.file_subtitle
    video.categories << category unless video.categories.include? category
    video.group = group
    video.set_width_height
    video.save
  end

  def is_video(name)
    name.downcase.end_with? '.mp4', '.m4v', '.webm'
  end

  def clean
    Video.find_each do |v|
      v.delete unless File.exist? File.join ROOT, v.path
    end
    Group.find_each do |v|
      v.delete unless File.exist? File.join ROOT, v.path
    end
    respond_to do |format|
      format.js {}
    end
  end

end
