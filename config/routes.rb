Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  mount ActionCable.server => "/cable"

  namespace :api do
    resources :rooms, only: [:index]
    resources :messages, only: [:index, :create]
    resources :chats, only: [:index]
    resources :users, only: [:index, :create, :show] do
      collection do
        post :login  
      end
    end
  end
end