class VideosController < ApplicationController

  def show
    begin
      @video = Video.find params[:id]
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end

  end

  def subtitle
    @video = Video.find params[:id]
    send_file File.join( AdminsController::ROOT, @video.subtitle_path)
  end


end
