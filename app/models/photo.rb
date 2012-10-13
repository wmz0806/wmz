#encoding: utf-8
class Photo < ActiveRecord::Base
  belongs_to :photo_album

  def self.judge_type(of_name)
    of_arr = of_name.split(".")
    of_suffix = of_arr[of_arr.length-1]
    if of_suffix =="jpg" || of_suffix =="png" || of_suffix =="gif" || of_suffix =="JPG" || of_suffix =="PNG" || of_suffix =="GIF"
    return of_suffix
    end
    false
  end

  def self.create_img_path(pa_id, img, name, info, session)
    begin

        path="/images/user_img/#{session[:user].id}/photoalbums/#{pa_id}/#{Photo.format_date(Time.new())}.#{judge_type(img.original_filename)}"

        if !File.exist?("public/images/user_img/#{session[:user].id}/photoalbums/#{pa_id}")
          Dir.mkdir("public/images/user_img/#{session[:user].id}/photoalbums/#{pa_id}")
        end

        File.open("public#{path}", "wb") do |f|
          f.write(img.read)
        end
        info = "暂无介绍" if info==""
        p=Photo.new(p_name: name, info: info , p_path: path ,photo_album_id: pa_id)
        return p.save
    rescue
      false
    end
  end

  def  self.delete_photo(id)
     p=Photo.find_by_id(id)
    if p
        File.delete("public#{p.p_path}");
        return p.destroy
    end
    false
  end


  def  self.format_date(time)
    return "#{time.year}#{time.month}#{time.day}#{time.hour}#{time.min}#{time.sec}"
  end
end
