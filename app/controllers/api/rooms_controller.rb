# app/controllers/api/rooms_controller.rb
class Api::RoomsController < ApplicationController
  def index
    user_id = params[:user_id].to_i

    # ⬇️ FIX: Query semua data sekaligus (1 query aja!)
    rooms = Room
      .where("user1_id = ? OR user2_id = ?", user_id, user_id)
      .includes(:messages)
      .references(:messages)

    # ⬇️ Ambil semua partner_ids sekaligus
    partner_ids = rooms.map { |r| r.other_user(user_id) }.uniq
    partners = User.where(id: partner_ids).index_by(&:id)

    # ⬇️ Map hasil dengan data yang udah di-cache
    result = rooms.map do |room|
      partner_id = room.other_user(user_id)
      partner = partners[partner_id]
      last_message = room.messages.max_by(&:created_at)

      {
        room_id: room.id,
        partner_id: partner_id,
        partner_username: partner&.username || "User #{partner_id}",
        last_message: last_message&.content,
        last_message_at: last_message&.created_at
      }
    end

    render json: result
  end
end