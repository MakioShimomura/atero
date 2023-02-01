Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # rootURLにアクセスした時にreslutsコントローラーのnewアクションを実行
  # root "articles#index"
  root "games#new"
  resources :games, only: [:new, :index, :create, :edit, :update, :show]
end
