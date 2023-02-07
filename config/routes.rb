Rails.application.routes.draw do
  root "games#new"
  resources :games, only: [:new, :index, :create, :edit, :update, :show]
  resources :matches, only: [:create]
  get 'play/:match_id/:game_id', to: 'matches#play', as: :match_play
  patch 'play/:match_id/:game_id', to: 'matches#update', as: :match_update
end
