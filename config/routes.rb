Rails.application.routes.draw do
  root "games#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  get    "/choices", to: "choices#index"
  resources :games, only: [:new, :index, :create, :edit, :update, :show]
  resources :choices, only:[:index, :create, :destroy]
end
