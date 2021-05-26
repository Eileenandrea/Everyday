Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  resources :categories, except: [:index]
  get 'dashboard', to: 'categories#index' 
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
end
