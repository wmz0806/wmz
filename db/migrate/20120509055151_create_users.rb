class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :hash_pwd
      t.string :salt
      t.integer :sex
      t.integer :age
      t.string :address
      t.string :head_img,  default: '/def_img/head/head.jpg'
      t.text :info
      t.datetime :birthday
      t.string :real_name
      t.string :email

      t.timestamps
    end
  end
end
