Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  namespace :api do
    resources :rooms, only: [:index]
    resources :messages, only: [:index, :create]
    resources :chats, only: [:index]
    resources :users, only: [:index, :create, :show]
  end
end
