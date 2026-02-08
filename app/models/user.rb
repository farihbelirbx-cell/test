# app/models/user.rb
class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  
  has_many :sent_messages, class_name: 'Message', foreign_key: 'user_id'
  
  def rooms
    Room.where("user1_id = ? OR user2_id = ?", id, id)
  end
end