require 'uri'

class VideosController < ApplicationController
  PREFIX = 'http://localhost:8080/videos/'
  def show
    video = Video.find params[:id] || render(status: 404)
    redirect_to URI.escape( PREFIX + video.path )
  end



end
