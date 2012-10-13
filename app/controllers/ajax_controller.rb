class AjaxController < ApplicationController
  before_filter :initialization_parameter_and_admin, :except => [:login, :logout, :verification_username]
  #登录
  def login
    user=User.verification_return_user(params[:username], params[:password])
    session[:user]=user

    respond_to do |format|
      format.js
    end
  end

  #注销
  def logout
    @uname=session[:user].username
    session[:user]=nil
  end

  #验证用户名是否重复
  def  verification_username
    username=params[:username]
    @user=User.find_by_username(username);
    respond_to do |format|
      format.js
    end
  end

  #修改相册名称
  def pa_edit
    @result=false
    id = params[:id]
    pa_name = params[:pa_name]
    if @is_admin && pa_name!=''
      PhotoAlbum.find_by_id(id).update_attributes(pa_name: pa_name)
      @result=true
    end
    respond_to do |format|
      format.js
    end
  end
  #修改相册封面
  def edit_cover
    @result=false
    id=params[:pa_id]
    path=params[:path]
    if @is_admin
      PhotoAlbum.find_by_id(id).update_attributes(cover: path)
      @result=true
    end

    respond_to do |format|
      format.js{ render :pa_edit }
    end
  end
 #修改主题
  def update_dressup
    d_id=params[:d_id]
    home_id=params[:home_id]
    home=Home.find_by_id(home_id)
    home.dressup_id=d_id
    home.save
    respond_to do |format|
      format.js
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

end


