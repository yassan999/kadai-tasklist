Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks, only: [:new, :edit, :update, :show, :create, :destroy]

  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  get 'users', to: 'tasks#index'
  resources :users, only: [:show, :new, :create]
end
