class VideosController < ApplicationController

  def show
    begin
      @video = Video.find params[:id]
      respond_to do |format|
        format.js {
          if is_mobile
            render inline: 'window.location = "' + @video.url + '"'
          else
            render
          end
        }
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end

  end

  def subtitle
    @video = Video.find params[:id]
    send_file File.join( Admin::ROOT, @video.subtitle_path)
  end

  def is_mobile
    request.headers[:HTTP_USER_AGENT].downcase.include? 'mobile'
  end


end
