Rails.application.routes.draw do
  root to: "tasks#index"
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy,:show]
  resources :users, only: [:new, :create, :destroy, :show]
end
