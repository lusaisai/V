require 'timeout'

class AdminController < ApplicationController
  include ActionController::Live

  ROOT = Rails.application.config.video_dir
  FULL_MODE = 0
  NEW_MODE = 1

  def scan
    mode = params[:mode].to_i
    log = IO.popen("node #{Rails.root.join 'app', 'bin', 'admin.js'}", 'r+')
    begin
      Timeout::timeout(5) {
        while 1 do
          break if log.gets == "start\n"
        end
      }
    rescue Timeout::Error
    end
    log.write "Start processing ...<br/>"
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
            group = Group.find_or_initialize_by path: File.join(base_dir, name)
            if group.new_record? || mode == FULL_MODE
              group.name = name
              group.with_image = File.exist? "#{name}/cover.jpg"
              group.save
            end

            Dir.entries(name).each do |video_name|
              next if video_name == '.' || video_name == '..'
              log.write "Processing #{video_name} ...<br/>"
              save_video File.join( base_dir, name, video_name), cate, group, mode
            end
            next
          end
          #single video files
          log.write "Processing #{name} ...<br/>"
          save_video File.join( base_dir, name), cate, nil, mode
        end
      end
    end

    log.write "Cleaning up ...<br/>"
    Video.all.each do |v|
      v.delete unless File.exist? File.join ROOT, v.path
    end
    Group.all.each do |g|
      g.delete unless Dir.exist? File.join ROOT, g.path
    end
    Category.all.each do |c|
      c.delete unless Dir.exist? File.join ROOT, c.name
    end

    log.write "End processing ...<br/>\n"
    log.close
    Process.waitpid log.pid
    render nothing: TRUE
  end

  def save_video( path, category, group, mode )
    return unless is_video(path)
    video = Video.find_or_initialize_by path: path
    return unless (video.new_record? || mode == FULL_MODE)
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
