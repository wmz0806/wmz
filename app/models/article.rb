#encoding : utf-8
class Article < ActiveRecord::Base
  validates_presence_of  :title,  :info,  message: '不能为空！'
  validates_length_of  :title, maximum:100, message: '长度不正确！'#minimum
  validates_length_of  :info, in: 10..3333, message: '长度不正确！'
  belongs_to :home
  has_many :comments, dependent: :destroy

  def format_date(time)
    return "#{time.year}-#{format_util time.month}-#{format_util time.day} #{format_util time.hour}:#{format_util time.min}:#{format_util time.sec}"
  end

  def  return_hot_articles

  end


  def self.return_current_page_articles(type, home_id, page)
     if type =="img"
       current_articles = Article.limit(10).offset((page.to_i-1)*10).order("created_at Desc").where("is_img=?",true).find_all_by_home_id(home_id)
     elsif type == "video"
       current_articles = Article.limit(10).offset((page.to_i-1)*10).order("created_at Desc").where("is_video=?",true).find_all_by_home_id(home_id)
     else
       current_articles = Article.limit(10).offset((page.to_i-1)*10).order("created_at Desc").find_all_by_home_id(home_id)
     end
    return current_articles
  end

  def self.count_page(type, home_id)
    if type =="img"
      length = Article.order("created_at Desc").where("is_img=?",true).find_all_by_home_id(home_id).count()
    elsif type == "video"
      length = Article.order("created_at Desc").where("is_video=?",true).find_all_by_home_id(home_id).count()
    else
      length = Article.order("created_at Desc").find_all_by_home_id(home_id).count()
    end
    if length>10
      page_temp=length%10
      if page_temp==0
        always_page =length/10
      else
        always_page= length/10+1
      end
    else
      always_page=1
    end
    return always_page
  end
  private
  def format_util(num)
     if num<10
       return "0#{num}"
     else
       return "#{num}"
    end
  end

end
