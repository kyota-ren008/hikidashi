Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'sessions/new'
  namespace :admin do
    resources :users
  end

  root to: 'posts#index'
  resources :posts do
  end
end
