# 💬 Simple Chat API

Real-time chat application API built with Ruby on Rails and Action Cable.

## 🚀 Tech Stack

- **Ruby**: 3.4.8
- **Rails**: 8.1.2
- **Database**: PostgreSQL (Supabase)
- **WebSocket**: Action Cable (async adapter)
- **Deployment**: Railway

## 📋 Prerequisites

- Ruby 3.3.6
- PostgreSQL
- Node.js (for ActionCable)

## ⚙️ Setup

### 1. Clone Repository
```bash
git clone <your-repo-url>
cd <project-folder>
```

### 2. Install Dependencies
```bash
bundle install
```

### 3. Environment Variables

Create `.env` file:
```env
DATABASE_URL=your_supabase_postgresql_url
```

### 4. Database Setup
```bash
rails db:create
rails db:migrate
```

### 5. Run Server
```bash
rails server
```

Server runs on `http://localhost:3000`

## 📡 API Endpoints

### Users

- `GET /api/users` - List all users
- `POST /api/users` - Register new user
- `POST /api/users/login` - Login by username
- `GET /api/users/:id` - Get user by ID

### Rooms

- `GET /api/rooms?user_id=:id` - Get user's chat rooms

### Messages

- `GET /api/messages?room_id=:id` - Get room messages
- `POST /api/messages` - Send message

### Health Check

- `GET /up` - Server health check

## 🔌 WebSocket

Connect to Action Cable:
```
ws://localhost:3000/cable (development)
wss://your-app.railway.app/cable (production)
```

### Channels

**RoomChannel** - Subscribe to specific room for messages:
```javascript
{ channel: "RoomChannel", room_id: 1 }
```

**UserChannel** - Subscribe to user notifications:
```javascript
{ channel: "UserChannel", user_id: 1 }
```

## 🚢 Deployment (Railway)

### 1. Connect Repository

Connect your GitHub repo to Railway

### 2. Environment Variables

Add in Railway dashboard:
```
DATABASE_URL=your_supabase_url
```

### 3. Deploy

Railway auto-deploys on push to main branch

### 4. Keep-Alive (Prevent Auto-Sleep)

Use UptimeRobot to ping `/up` endpoint every 5 minutes

## 📦 Database Schema

### Users
- `id` (primary key)
- `username` (unique, indexed)
- `created_at`
- `updated_at`

### Rooms
- `id` (primary key)
- `user1_id` (foreign key)
- `user2_id` (foreign key)
- `created_at`
- `updated_at`

### Messages
- `id` (primary key)
- `content` (text)
- `username` (string)
- `user_id` (foreign key)
- `room_id` (foreign key)
- `created_at`
- `updated_at`

## 🔧 Configuration

### CORS

Allowed origins configured in `config/initializers/cors.rb`:
- `http://localhost:3001` (development)
- Your production frontend URL

### Action Cable

Uses `async` adapter (in-memory) for both development and production.

⚠️ **Note**: Async adapter is suitable for single-instance deployments. For multiple instances, consider Redis.

## 🐛 Common Issues

### WebSocket Connection Failed

**Problem**: `Request origin not allowed`

**Solution**: Add your frontend URL to:
- `config/initializers/cors.rb`
- `config/environments/production.rb` (action_cable.allowed_request_origins)

### Database Connection Error

**Problem**: `prepared statement already exists`

**Solution**: Already fixed with `prepared_statements: false` in `database.yml`

## 📝 License

MIT

## 👨‍💻 Author

Muhamad Ramadhifan Baiqi
