#encoding: utf-8
class HomesController < ApplicationController
  # GET /homes
  # GET /homes.json
  layout "login", :except => [:new, :show]
  def index
    @new_user=User.limit(10).order("created_at DESC").all()
  end

  # GET /homes/2
  # GET /homes/2.json
  def show
    @current_home=Home.find_by_id(params[:id])
    if @current_home
      @current_user = @current_home.user
      @current_articles = Article.order("updated_at Desc").limit(10).find_all_by_home_id(@current_home.id)
      @comments = Comment.order("updated_at Desc").limit(5).find_all_by_home_id(@current_home.id)
      @current_dressup = @current_home.dressup
      @dressups=Dressup.all();
      @is_admin=true if session[:user] && session[:user].id==@current_user.id
      Home.add_visitor_list(@current_home, session) if session[:user]
      @home_list=Home.select_visitor_list(@current_home)
      @imgs = @current_home.photo_albums.first if  @current_home.photo_albums
      @message_boards = MessageBoard.limit(5).order("created_at DESC").find_all_by_home_id(@current_home.id)
      render layout: "show_home"

    else
      redirect_to homes_path
    end


  end

  # GET /homes/new
  # GET /homes/new.json
  #注册
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /homes/2/edit
  def edit
  end

  # POST /homes
  # POST /homes.json
  #注册后创建
  def create
    u=params[:user]
  u[:real_name]=u[:username]


  @user = User.new(u)

  respond_to do |format|
    if !(u[:password]  !~  /^[\da-zA-z]{6,12}$/) && @user.save
      session[:user]=User.create_full_user(@user)
      format.html
    else
      @user.errors[:password]='格式不正确'  if !(u[:password]  !~  /^[\da-zA-z]{6,12}$/)
      format.html { render action: "new" }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end



end
