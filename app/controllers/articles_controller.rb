#encoding: utf-8
class ArticlesController < ApplicationController
  layout "show_home"
  before_filter :initialization_parameter_and_admin
  before_filter :initialization_parameter, :except => [:create, :destroy]
  def index
    type = params[:type]
    @page = params[:page]
    @page = 1 if @page.nil?
    if type =="img"
        @module_title ="图片博文"
    elsif type=="video"
      @module_title ="视频博文"
    else
      @module_title="全部博文"
     end
    @current_articles = Article.return_current_page_articles(type, @current_home.id, @page);
    @always_page = Article.count_page(type, @current_home.id)
  end

  def new
    @article = Article.new
  end

  def create

    a=params[:article]
    html_str=a[:info]
    if !(html_str  !~ /<img/)
      a[:is_img]=true
    end
   if !(html_str !~ /<embed/)
     a[:is_video]=true
   end


    a[:home_id]=params[:home_id]
    @article=Article.new(a)

     respond_to do |format|
       if  @is_admin && @article.save
         format.html{redirect_to action: 'index'}
       else
         @current_home=Home.find_by_id(params[:home_id])
         initialization_parameter_and_admin
         initialization_parameter
         format.html { render action: "new" }
         format.json { render json: @article.errors, status: :unprocessable_entity }
       end
     end
  end

  def show
    @article=Article.find_by_id(params[:id])
    @article.read_number=@article.read_number+1
    @article.save
    @comments = Comment.find_all_by_article_id(@article.id)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy if @is_admin
      respond_to do |format|
        format.html{redirect_to action: 'index'}
      end
  end

  def update

    @article = Article.find(params[:id])
    if @is_admin &&  @article.update_attributes(params[:article])
      redirect_to home_article_path(@current_home,@article)
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
