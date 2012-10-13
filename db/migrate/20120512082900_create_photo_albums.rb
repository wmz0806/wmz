#encoding: utf-8
class CreatePhotoAlbums < ActiveRecord::Migration
  def change
    create_table :photo_albums do |t|
      t.string :pa_name, default: '相册'
      t.string :info, default: '暂无介绍'
      t.string :cover, default: '/def_img/photo/cover/cover.png'
      t.integer :home_id

      t.timestamps
    end
  end
end
