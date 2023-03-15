Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root "games#index"
  resources :games, only: %i[index create edit update show]
  resources :choices, only: %i[index create destroy]
  resources :matches, only: %i[create]
  resources :questions, only: %i[index create destroy]
  post 'questions/choice_predict', :controller => 'questions', :action => 'choice_predict'
  post 'questions/label_detection', to: 'questions#label_detection'
  get 'play/:match_id/:game_id', to: 'matches#play', as: :match_play
  patch 'play/:match_id/:game_id', to: 'matches#update', as: :match_update
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
end
