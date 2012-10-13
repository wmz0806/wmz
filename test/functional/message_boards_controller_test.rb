require 'test_helper'

class MessageBoardsControllerTest < ActionController::TestCase
  setup do
    @message_board = message_boards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:message_boards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message_board" do
    assert_difference('MessageBoard.count') do
      post :create, message_board: @message_board.attributes
    end

    assert_redirected_to message_board_path(assigns(:message_board))
  end

  test "should show message_board" do
    get :show, id: @message_board
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @message_board
    assert_response :success
  end

  test "should update message_board" do
    put :update, id: @message_board, message_board: @message_board.attributes
    assert_redirected_to message_board_path(assigns(:message_board))
  end

  test "should destroy message_board" do
    assert_difference('MessageBoard.count', -1) do
      delete :destroy, id: @message_board
    end

    assert_redirected_to message_boards_path
  end
end
