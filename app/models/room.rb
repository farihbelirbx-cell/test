class Room < ApplicationRecord
  has_many :messages

  def self.find_or_create_private_room(user_a, user_b)
    u1, u2 = [user_a, user_b].sort

    room = Room.find_by(user1_id: u1, user2_id: u2)
    return room if room

    Room.create(user1_id: u1, user2_id: u2)
  end

  def other_user(current_user_id)
    user1_id == current_user_id.to_i ? user2_id : user1_id
  end
end
