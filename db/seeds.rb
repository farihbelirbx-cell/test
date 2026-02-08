# db/seeds.rb
User.destroy_all
Room.destroy_all
Message.destroy_all

users = ['dhifan', 'andi', 'budi', 'citra', 'deni'].map do |name|
  User.create!(username: name)
end

# Bikin rooms untuk dhifan
Room.create!(user1_id: users[0].id, user2_id: users[1].id) # dhifan <-> andi
Room.create!(user1_id: users[0].id, user2_id: users[2].id) # dhifan <-> budi

puts "✅ Created #{User.count} users, #{Room.count} rooms"