Rails.application.routes.draw do
  root "games#new"
  resources :games, only: [:new, :index, :create, :edit, :update, :show]
end
