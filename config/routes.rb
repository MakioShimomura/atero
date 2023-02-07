Rails.application.routes.draw do
  root "games#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :games, only: [:new, :index, :create, :edit, :update, :show]
  resources :questions, only: [:new, :create, :destroy, :index]
end
