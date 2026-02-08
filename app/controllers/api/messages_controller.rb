class Api::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    room = Room.find(params[:room_id])
    messages = room.messages.order(:created_at)
    render json: messages
  end

  def create
    room = Room.find_or_create_private_room(
      message_params[:sender_id],
      message_params[:receiver_id]
    )   

    message = room.messages.new(
      username: message_params[:username],
      content: message_params[:content],
      user_id: message_params[:sender_id]  
    )

    if message.save
      # 1️⃣ Broadcast ke room channel (untuk realtime chat)
      ActionCable.server.broadcast(
        "private_room_#{room.id}",
        {
          id: message.id,
          content: message.content,
          user_id: message.user_id,
          room_id: room.id,
          created_at: message.created_at
        }
      )

      [message_params[:sender_id], message_params[:receiver_id]].each do |user_id|
        ActionCable.server.broadcast(
          "user_#{user_id}",
          {
            type: 'room_update',
            room_id: room.id
          }
        )
      end

      render json: { room_id: room.id, message: message }, status: :created
    else
      render json: { errors: message.errors }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message)
      .permit(:username, :content, :sender_id, :receiver_id)
  end
end