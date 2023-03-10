Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root "games#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :games, only: %i[new index create edit update show]
  resources :questions, only: %i[index new create destroy]
  post 'questions/choice_predict', :controller => 'questions', :action => 'choice_predict'
  resources :choices, only: %i[index create destroy]
  resources :matches, only: %i[create]
  get 'play/:match_id/:game_id', to: 'matches#play', as: :match_play
  patch 'play/:match_id/:game_id', to: 'matches#update', as: :match_update
  post 'questions/label_detection', to: 'questions#label_detection'
end
