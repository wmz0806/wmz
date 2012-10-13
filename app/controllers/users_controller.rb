class UsersController < ApplicationController
  layout "show_home"
  before_filter :initialization_parameter_and_admin
  before_filter :initialization_parameter, :except => [:create, :destroy]

  def show
  end

  def update
     user=params[:user]
     year=params[:year]
     img=params[:img]
     month=params[:month]
     day=params[:day]
     time=Time.local(year, month, day)

     @current_user.salt;
     @current_user.hash_pwd;
    if @is_admin && user[:age].to_i.to_s == user[:age] && @current_user.update_attributes!(age: user[:age].to_i, sex: user[:sex].to_i, real_name: user[:real_name], address: user[:address], info: user[:info], birthday: time, password: @current_user.password);
      if img
        path=User.edit_user_head_img(img, session)
        if path
          @current_user.head_img=path
          @current_user.save
        end
      end
      redirect_to home_user_path(@current_home, @current_user)
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
    @current_dressup = @current_home.dressup
    @dressups=Dressup.all();
  end
end
