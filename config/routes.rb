Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'signup', to: 'users#new'
  
  resources :users, except: [:new]
  resources :categories do
    resources :tasks do
      resources :comments, only: [:new,:create]
      
    end
  end

  get 'dashboard', to: 'categories#dashboard' 
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
