class Video < ActiveRecord::Base
  has_and_belongs_to_many :categories
  belongs_to :group

  def image_path
    path.sub(/\.[^.]*$/, '') + '.jpg'
  end

  def subtitle_path
    path.sub(/\.[^.]*$/, '') + '.srt'
  end

end
