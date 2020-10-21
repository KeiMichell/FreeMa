Rails.application.routes.draw do
  resources :product_detail, only: [:show]
  resources :users, only: :show
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
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
end
