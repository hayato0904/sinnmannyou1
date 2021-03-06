Rails.application.routes.draw do
  resources :labels
  get 'sessions/new'
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tasks#index"
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]

  namespace :admin do
    resources :users
  end

end
