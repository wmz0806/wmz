#encoding: utf-8
class CreateDressups < ActiveRecord::Migration
  def change
    create_table :dressups do |t|
      t.string :background, default: '#000000'
      t.string :background_img, default: '/def_img/dressup/1/bg.gif'
      t.string :menu_bg, default: '/def_img/dressup/1/menu.gif'
      t.string :module_bg, default: '/def_img/dressup/1/module_bg.jpg'
      t.string :a_before, default: '#ffffff'
      t.string :a_after, default: '#808080'
      t.string :module_title_bg, default: '/def_img/dressup/1/module_title.gif'
      t.string :article_bg_up, default: '/def_img/dressup/1/article_up.gif'
      t.string :article_bg_down, default: '/def_img/dressup/1/article_down.gif'
      t.string :up_scene, default: '/def_img/dressup/1/up.jpg'
      t.string :down_scene, default: '/def_img/dressup/1/down.jpg'
      t.string :font_color, default: '#808080'
      t.string :title, default: '未命名'
      t.string :img_path, default: '/def_img/dressup/1/img.gif'
      t.integer :hot, default: 0

      t.timestamps
    end
  end
end
