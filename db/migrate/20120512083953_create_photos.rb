#encoding: utf-8
class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :p_name
      t.string :info, default: '暂无介绍'
      t.integer :photo_album_id
      t.string :p_path

      t.timestamps
    end
  end
end
