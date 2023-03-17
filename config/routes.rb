Rails.application.routes.draw do
  require 'sidekiq/web'

  resources :places do
    resources :forecasts, only: [:show, :create, :edit]
  end
  resources :forecasts, only: [:index, :new, :update, :destroy]
  root 'weather#index'

  mount Sidekiq::Web, at: '/sidekiq'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
