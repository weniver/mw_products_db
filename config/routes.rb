Rails.application.routes.draw do
  root               'static_pages#home'
  get    'signup' => 'users#new'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get    'telas_estampados' => 'patterns#index'

  resources :patterns, :fabrics, :users, :products, :categories, :units, :stores
  resources :password_resets,        only: [:new, :create, :edit, :update]
  resources :batches,                only: [:index, :destroy]
  resources :account_activations,    only: [:edit]
  resources :remissions do
    member do
      get :download
      post :end
      post :activate
      put :sold
    end
  end
  resources :stores do
    member do
      get :inventory
    end
  end
end
