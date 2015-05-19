class HomeController < ApplicationController
  skip_before_action :authorize
  
  def index
    @videos = []

    group_chosen = {}
    Video.all.to_a.shuffle!.each { |video|
      if video.group_id == nil
        @videos << video
      else
        if group_chosen.has_key? video.group_id
          next
        else
          @videos << video
          group_chosen[video.group_id] = true
        end
      end
    }
    @videos.shuffle!
    @categories = Category.all
    @category_id = 0
    @user = User.find_by_id session[:user_id]
  end
end
