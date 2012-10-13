#encoding: utf-8
class PhotosController < ApplicationController
  layout "show_home"
  before_filter :initialization_parameter_and_admin
  before_filter :initialization_parameter, :except => [:create, :destroy]

  # GET /photos
  # GET /photos.json
  def  index
    @home_id=params[:home_id]
    @id=params[:photo_album_id]
    @pa=PhotoAlbum.find_by_id(@id)
    if @pa
      @photos=@pa.photos
    else
      redirect_to home_photo_albums_path
    end
  end

  def create
    @photo_album_id = params[:photo_album_id]
    @home_id = params[:home_id]
    @image = params[:image]
    flash[:notice]='添加失败！'

     if @image && Photo.judge_type(@image.original_filename)
       @info = params[:info]
       params[:p_name] ? @p_name=@image.original_filename : @p_name=params[:p_name]
       flash[:notice]='添加成功！' if  Photo.create_img_path(@photo_album_id, @image, @p_name, @info, session)
     end
    redirect_to home_photo_album_photos_path(@home_id, @photo_album_id)
  end

  def  destroy
    @photo_album_id = params[:photo_album_id]
    @home_id = params[:home_id]
    flash[:notice]='删除失败！'
    if @is_admin && Photo.delete_photo(params[:id])
      flash[:notice]='删除成功！'
    end
    redirect_to home_photo_album_photos_path(@home_id, @photo_album_id)
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
    @current_dressup = @current_home.dressup
    @dressups=Dressup.all();
  end
end
