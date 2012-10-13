class MessageBoard < ActiveRecord::Base
  belongs_to :home
  belongs_to :user

  def self.return_current_page_message_boards(home_id, page)
    return MessageBoard.limit(10).offset((page.to_i-1)*10).order("created_at Desc").find_all_by_home_id(home_id)
  end

  def self.count_page(home_id)
    length = MessageBoard.order("created_at Desc").find_all_by_home_id(home_id).count()
    if length>10
      page_temp=length%10
      if page_temp==0
        always_page =length/10
      else
        always_page= length/10+1
      end
    else
      always_page=1
    end
    return always_page
  end

  def self.return_reply_message_board(message_board)
     if message_board.is_reply
       return mb=MessageBoard.find_by_id(message_board.message_id);
     end
    false
  end

end
