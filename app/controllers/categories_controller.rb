class CategoriesController < ApplicationController
  def show
    @category_id = params[:id]
    @videos = Category.find(@category_id).videos.where( group_id: nil ).to_a
    Group.all.each do |group|
      video = group.videos.order('random()').take()
      @videos << video if video.category_ids.include? @category_id.to_i
    end
    @videos.shuffle!
    @categories = Category.all
  end
end
