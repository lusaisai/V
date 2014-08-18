class VideosController < ApplicationController

  def show
    begin
      @video = Video.find params[:id]
      respond_to do |format|
        format.html {}
        format.js {}
      end
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end

  end

  def subtitle
    @video = Video.find params[:id]
    send_file File.join( Admin::ROOT, @video.subtitle_path)
  end


end
