Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :areas, only: [:show]
  resources :dashboards, only: [:index]

  root to: "dashboards#index"
end
