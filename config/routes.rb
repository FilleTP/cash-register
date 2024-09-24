Rails.application.routes.draw do
  root to: "products#index"
  resources :cart, only: :show
  resources :line_items, only: :create
end
