class Api::ChatsController < ApplicationController
  def index
    user_id = params[:user_id]

    rooms = Room
      .where("user1_id = ? OR user2_id = ?", user_id, user_id)
      .includes(:messages)

    result = rooms.map do |room|
      partner_id =
        room.user1_id.to_s == user_id ? room.user2_id : room.user1_id

      last_message = room.messages.order(created_at: :desc).first

      {
        room_id: room.id,
        partner_id: partner_id,
        last_message: last_message&.content,
        last_message_at: last_message&.created_at
      }
    end

    render json: result
  end
end
