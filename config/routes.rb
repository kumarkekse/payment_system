Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/authenticate', to: 'authentication#authenticate'
      resources :transactions, only: :create
    end
  end

  devise_for :users
  root to: 'users#index'
  resources :users do
    resources :transactions, only: :index
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
