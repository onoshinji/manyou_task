Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy,:show]
  resources :users
  namespace :admin do
    resources :users
  end
end
