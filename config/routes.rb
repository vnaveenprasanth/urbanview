Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root "posts#index"

  get 'signup', to: 'users#new'
  resources :users, except: [:new] do
  member do
    post 'follow', to: 'users#follow'
    delete 'unfollow', to: 'users#unfollow'
  end
end
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to:'sessions#destroy'

  get '/password/reset', to: 'password_resets#new'
  post '/password/reset', to: 'password_resets#create'
  get '/password/reset/edit', to: 'password_resets#edit'
  patch '/password/reset/edit', to: 'password_resets#update'

  resources :posts do
    resources :comments
    resources :interactions, only: %i[create destroy], controller: 'interactions'
    resources :chats

  end


end
