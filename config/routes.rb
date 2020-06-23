Rails.application.routes.draw do
  root to: "task#index"
  resources :tasks
end
