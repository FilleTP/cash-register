Rails.application.routes.draw do
  root to: "products#index"
  resource :cart, only: :show
  resources :products, only: [] do
    resources :line_items, only: :create
  end
  resources :line_items, only: :destroy
end
