# app/controllers/api/users_controller.rb
class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /api/users - List semua user
  def index
    users = User.all.order(:username)
    render json: users.select(:id, :username)
  end

  # POST /api/users - Register user baru
  def create
    user = User.new(username: params[:username]&.strip)
    
    if user.save
      render json: { id: user.id, username: user.username }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /api/users/login - Login by username
  def login
    username = params[:username]&.strip
    
    if username.blank?
      return render json: { error: 'Username is required' }, status: :bad_request
    end

    user = User.find_by(username: username)
    
    if user
      render json: { id: user.id, username: user.username }, status: :ok
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  # GET /api/users/:id - Get user by ID
  def show
    user = User.find(params[:id])
    render json: { id: user.id, username: user.username }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end
end