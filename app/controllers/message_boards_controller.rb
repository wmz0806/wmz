class MessageBoardsController < ApplicationController
  layout "show_home"
  before_filter :initialization_parameter_and_admin
  before_filter :initialization_parameter, :except => [:create, :destroy]
  # GET /message_boards
  # GET /message_boards.json
  def index
    @home_id = params[:home_id]
    params[:page] ? @page =  params[:page] : @page = 1
    @message_boards = MessageBoard.return_current_page_message_boards(@home_id, @page)
    @always_page = MessageBoard.count_page(@home_id)

  end


  # POST /message_boards
  # POST /message_boards.json
  def create
    info = params[:info]
    @home_id = params[:home_id]
    mb=MessageBoard.new(info: info, home_id: @home_id, user_id: session[:user].id);
    redirect_to home_message_boards_path(@home_id) if mb.save
   end

  # PUT /message_boards/1
  # PUT /message_boards/1.json
  def update
    @message_board = MessageBoard.find(params[:id])

    respond_to do |format|
      if @message_board.update_attributes(params[:message_board])
        format.html { redirect_to @message_board, notice: 'Message board was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message_board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_boards/1
  # DELETE /message_boards/1.json
  def destroy
    @message_board = MessageBoard.find(params[:id])
     @message_board.destroy  if @is_admin
    redirect_to home_message_boards_path(@current_home)
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
