Rails.application.routes.draw do
  resources :product_detail, only: [:show]
  root 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
