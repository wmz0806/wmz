class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :info
      t.integer :user_id
      t.integer :article_id
      t.integer :home_id

      t.timestamps
    end
  end
end
