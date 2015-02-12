class HomeController < ApplicationController
  def index
    @videos = Video.where( group_id: nil ).to_a
    Group.all.each do |group|
      @videos << group.videos.order('random()').take
    end
    @videos.shuffle!
    @categories = Category.all
    @category_id = 0
    @user = User.find_by_id session[:user_id]
  end
end
