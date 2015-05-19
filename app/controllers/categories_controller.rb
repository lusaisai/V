class CategoriesController < ApplicationController
  skip_before_action :authorize

  def show
    @category_id = params[:id]
    @videos = []

    group_chosen = {}
    Category.find(@category_id).videos.to_a.shuffle!.each { |video|
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
    @user = User.find_by_id session[:user_id]
  end
end
