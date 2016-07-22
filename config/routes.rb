Rails.application.routes.draw do

  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  root to: 'movies#index'

  get '/switch_back', to: 'application#switch_back', as: 'switch_back'

  namespace :admin do
    resources :users, only: [:new, :index, :create, :edit, :update, :destroy]
    get 'users/spoof_user/:id', to: 'users#spoof_user', as: 'spoof_user'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
