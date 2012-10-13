class CommentsController < ApplicationController

  # POST /comments
  # POST /comments.json
  def create
    @home_id=params[:home_id]
    @article_id=params[:article_id]
    com=params[:comment]
    com[:article_id]=@article_id
    com[:user_id] = session[:user].id
    com[:home_id] = @home_id
    @comment = Comment.new(com)
    if @comment.save
        redirect_to home_article_path(@home_id, @article_id)
    end
  end

  # PUT /comments/2
  # PUT /comments/2.json
  def update
    @home_id=params[:home_id]
    @article_id=params[:article_id]
    @comment = Comment.find(params[:id])
    if session[:user] && session[:user].id==@comment.user_id &&  @comment.update_attributes(info: params[:comment][:info])
      redirect_to home_article_path(@home_id, @article_id)
    end
  end

  # DELETE /comments/2
  # DELETE /comments/2.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy  if @comment.user_id==session[:user].id || params[:home_id]==session[:user].home.id
    redirect_to home_article_path(params[:home_id], params[:article_id])
  end
end
