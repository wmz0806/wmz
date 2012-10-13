class CreateMessageBoards < ActiveRecord::Migration
  def change
    create_table :message_boards do |t|
      t.text :info
      #t.boolean :is_master, default: true
      #t.boolean :is_reply, default: false
      t.integer :user_id
      t.integer :home_id
      #t.integer :message_id

      t.timestamps
    end
  end
end
