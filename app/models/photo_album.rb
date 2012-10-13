class PhotoAlbum < ActiveRecord::Base
  belongs_to :home
  has_many :photos

  def  judge_cover(pa)
    if !File.exist?("public#{pa.cover}")
     pa.update_attributes(cover: '/def_img/photo/cover/cover.png')
    end
    return pa
  end
end
