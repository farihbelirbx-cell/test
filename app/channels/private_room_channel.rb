class PrivateRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "private_room_#{params[:room_id]}"
  end
end
