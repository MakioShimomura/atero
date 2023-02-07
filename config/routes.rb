Rails.application.routes.draw do
  root "games#new"
  resources :games, only: [:new, :index, :create, :edit, :update, :show]
  resources :questions, only: [:new, :create, :destroy, :index]
end
