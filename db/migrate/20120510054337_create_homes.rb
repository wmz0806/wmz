class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :title
      t.integer :rank, default: 1
      t.integer :visit, default: 0
      t.integer :exp, default: 0
      t.integer :attention, default: 0
      t.boolean :is_img, default: false
      t.boolean :is_music, default: false
      t.string :visitor_list
      t.integer :user_id
      t.integer :dressup_id, default: 1

      t.timestamps
    end
  end
end
