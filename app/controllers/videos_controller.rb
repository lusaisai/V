class VideosController < ApplicationController
  PREFIX = 'http://localhost:8080/videos/'
  def show
    begin
      @video = Video.find params[:id]
    rescue ActiveRecord::RecordNotFound
      redirect_to root_path
    end

  end



end
