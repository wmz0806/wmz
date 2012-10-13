#encoding: utf-8
class User < ActiveRecord::Base
  validates_presence_of  :username, :email, message: "不能为空！"
  validates_uniqueness_of :username, message: "用户名不能重复"
  validates_format_of  :username, with: /^[a-zA-z][\da-zA-z]{5,11}$/, message: "用户名格式错误"
  validates_format_of :email, with: /^[a-zA-Z\d_\.\-]{6,12}@[a-zA-Z\d\-]{2,6}\.(com||cn)$/, message: "用户名格式错误"


  has_one :home
  has_many :comments
  has_many :message_boards
  def password
    @pwd
  end

  def  password=(pass)
    return unless pass
    @pwd = pass
    generate_password(pass)
  end


  def self.verification_return_user(username, pass)
       user=User.find_by_username(username)
       if user && Digest::SHA256.hexdigest(pass+user.salt)  == user.hash_pwd
         return user
       end
       false
  end

  def self.create_full_user(u)
    user=User.find_by_username(u.username)
    Home.create_home_relevance_user(user)
    if !File.exists?("public/images/user_img/#{user.id}")
      Dir.mkdir("public/images/user_img/#{user.id}")
    end
    return user
  end

  def self.edit_user_head_img(img, session)
    if Photo.judge_type(img.original_filename)
      path="/images/user_img/#{session[:user].id}/head.#{Photo.judge_type(img.original_filename)}"
      File.open("public#{path}", "wb") do |f|
        f.write(img.read)
      end
      return path
    end
    false
  end

  private
  def generate_password (pass)
    salt = Array.new(10){rand(1024).to_s(36)}.join
    self.salt, self.hash_pwd = salt, Digest::SHA256.hexdigest(pass+salt)
  end
end
