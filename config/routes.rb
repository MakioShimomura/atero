Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root "games#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  get    "/choices", to: "choices#index"
  resources :games, only: [:new, :index, :create, :edit, :update, :show]
  resources :choices, only:[:index, :create, :destroy]
  resources :matches, only: [:create]
  get 'play/:match_id/:game_id', to: 'matches#play', as: :match_play
  patch 'play/:match_id/:game_id', to: 'matches#update', as: :match_update
end
