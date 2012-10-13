#encoding: utf-8
class Home < ActiveRecord::Base
  belongs_to :user
  belongs_to :dressup
  has_many :articles
  has_many :photo_albums
  has_many :comments
  has_many :message_boards
  def  self.create_home_relevance_user(user)
    home=Home.new(user: user, title: "#{user.real_name}的家")
    home.save
  end

  #存入访客
  def self.add_visitor_list(home, session)
    home_id=session[:user].home.id
     if session[:user] && home_id != home.id
        home_arr=return_arr(home)
      if home_arr
          if   home_arr.include?(home_id.to_s)
            home_arr.each do |ha|
                if ha==home_id.to_s
                  home_arr.delete(ha)
                  break
                end
            end
          elsif home_arr.length>=20
            home_arr.delete(home_arr[0])
          end
      else
        home_arr=[]
       end
       home_arr << home_id
       home.visitor_list= home_arr.join(",")
       return home.save
     end
    false
  end

  #取出访客
  def self.select_visitor_list(home)
      home_arr=return_arr(home)
      home_list=[]
      if home_arr
       home_arr.reverse.each do  |ha|
           home_list << Home.find_by_id(ha);
       end
    end
    return home_list
  end

  private
  def self.return_arr(home)
      home_arr=[]
     home_arr=home.visitor_list.split(",")  if home.visitor_list
  end

end
