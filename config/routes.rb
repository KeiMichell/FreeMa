Rails.application.routes.draw do
  resources :items do
    collection do
      get 'get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'purchase'
    end
    resources :favorites, only: [:index, :create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  resources :cards, only: [:index, :new, :show] do
    collection do
      post 'create', to: 'cards#create'
      post 'delete', to: 'cards#delete'
    end
  end
  resources :users, only: :show
end
