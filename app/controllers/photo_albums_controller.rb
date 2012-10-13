#encoding: utf-8
class PhotoAlbumsController < ApplicationController
  layout "show_home", :except => [:create]
  before_filter :initialization_parameter_and_admin
  before_filter :initialization_parameter, :except => [:create, :destroy]
  def index
    @current_pa =  @current_home.photo_albums
  end


  def create
     pa=PhotoAlbum.new(params[:photo_album])
     pa[:pa_name] = '新建相册' if pa[:pa_name]==""
     pa[:info] = '暂无简介' if pa[:info]==""

     if !(File.exist?("public/images/user_img/#{session[:user].id}/photoalbums"))
       Dir.mkdir("public/images/user_img/#{session[:user].id}/photoalbums")
     end
     if pa.save
        redirect_to home_photo_albums_path
     end
  end


  def  destroy
    pa = PhotoAlbum.find(params[:id])
    if File.exist?("public/images/user_img/#{session[:user].id}/photoalbums/#{params[:id]}")
      pa.photos.each do |p|
        File.delete("public"+p.p_path)
        p.destroy
      end
      Dir.rmdir("public/images/user_img/#{session[:user].id}/photoalbums/#{params[:id]}")
    end

    pa.destroy if @is_admin

    respond_to do |format|
      format.html{redirect_to action: 'index'}
    end
  end

  private
  def  initialization_parameter_and_admin
    @current_home=Home.find_by_id(params[:home_id])
    if @current_home
      @current_user = @current_home.user
      @is_admin=true if session[:user] && session[:user].id==@current_user.id
    else
      redirect_to homes_path
    end
  end

  def  initialization_parameter
    @dressups=Dressup.all();
    @current_dressup = @current_home.dressup
  end
end
