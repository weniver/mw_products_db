Rails.application.routes.draw do
  root               'static_pages#home'
  get    'signup' => 'users#new'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get    'telas_estampados' => 'patterns#index'
  
  resources :patterns
  resources :fabrics
  resources :users
  resources :account_activations,    only: [:edit]
  resources :password_resets,        only: [:new, :create, :edit, :update]
  resources :products
  resources :categories
  resources :units
end
