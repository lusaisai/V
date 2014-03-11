class AdminController < ApplicationController
  include ActionController::Live

  ROOT = 'N:/Videos'

  def scan
    log = IO.popen("node #{Rails.root.join 'app', 'bin', 'admin.js'}", 'w')
    log.write "Start processing ...\n"
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
            log.write "Entering #{name} ...<br/>"
            group = Group.find_or_create_by path: File.join(base_dir, name)
            group.name = name
            group.with_image = File.exist? "#{name}/cover.jpg"
            group.save

            Dir.entries(name).each do |video_name|
              next if video_name == '.' || video_name == '..'
              log.write "Processing #{video_name} ...<br/>"
              save_video File.join( base_dir, name, video_name), cate, group
            end
            next
          end
          #single video files
          log.write "Processing #{name} ...<br/>"
          save_video File.join( base_dir, name), cate, nil
        end
      end
    end

    log.write "Cleaning up ...<br/>"
    Video.find_each do |v|
      v.delete unless File.exist? File.join ROOT, v.path
    end
    Group.find_each do |g|
      g.delete unless Dir.exist? File.join ROOT, g.path
    end
    Category.find_each do |c|
      c.delete unless Dir.exist? File.join ROOT, c.name
    end

    log.write "End processing ...<br/>"
    log.write 'stop'
    render nothing: TRUE
  end

  def save_video( path, category, group )
    return unless is_video(path)
    video = Video.find_or_create_by path: path
    video.name = File.basename(path).sub /\.[^.]*$/, ''
    video.with_image = File.exist? video.image_file
    video.ass2srt
    video.with_subtitle = File.exist? video.subtitle_file
    video.categories << category unless video.categories.include? category
    video.group = group
    video.set_width_height
    video.save
  end

  def is_video(name)
    name.downcase.end_with? '.mp4', '.m4v', '.webm'
  end


end
