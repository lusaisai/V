class HomeController < ApplicationController
  def index
    @videos = Video.where( group_id: nil )
    Group.all.each do |group|
      @videos << group.videos.order('random()').take()
    end
    @videos.shuffle!
    @categories = Category.all
    @category_id = 0
  end
end
