#encoding: utf-8
class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, default: '无标题'
      t.text :info
      t.integer :read_number, default: 0
      t.integer :reprint_number, default: 0
      t.string :reprint_path
      t.boolean :is_img, default: false
      t.boolean :is_video, defaule: false
      t.integer :home_id

      t.timestamps
    end
  end
end
