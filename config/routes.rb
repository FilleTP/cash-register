Rails.application.routes.draw do
  get 'line_items/create'
  get 'carts/show'
  get 'products/index'
  root to: "products#index"
  resource :cart, only: :show
  resources :line_items, only: :create
end
