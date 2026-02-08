# app/channels/room_channel.rb
class RoomChannel < ApplicationCable::Channel
  def subscribed
    room_id = params[:room_id]
    reject unless room_id.present?

    stream_from "private_room_#{room_id}"
  end

  def unsubscribed
    stop_all_streams
  end
end