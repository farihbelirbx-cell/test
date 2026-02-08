# app/models/user.rb
class User < ApplicationRecord
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :sent_messages, class_name: 'Message', foreign_key: 'user_id'
  
  def rooms
    Room.where("user1_id = ? OR user2_id = ?", id, id)
  end
  
  # Normalize username before save
  before_validation :normalize_username
  
  private
  
  def normalize_username
    self.username = username&.strip&.downcase
  end
end