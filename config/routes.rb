Rails.application.routes.draw do
  
  get   'posts/replies/:comment_id/:point', to: 'posts#replies'

  root 'static_pages#home'
  
  get   '/help',    to: 'static_pages#help'
  get   '/about',   to: 'static_pages#about'
  get   '/contact', to: 'static_pages#contact'
  
  get   '/signup',  to: 'users#new'
  post  '/signup',  to: 'users#create'
  get   '/login',   to: 'sessions#new'
  post  '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  
  resources :posts do
    member do
      get :thumb
    end
  end
  
  resources :posts, only: [:create, :destroy] 
  
  resources :account_activation, only: [:edit]
  
  resources :password_resets, only: [:new, :create, :edit, :update]
  
  resources :relationships,   only: [:create, :destroy]
  
  resources :comments,   only: [:create, :destroy]
  
  resources :replies,   only: [:create, :destroy]
  


end
