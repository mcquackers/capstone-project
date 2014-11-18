Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show] do
    resource :marketplace, only: [:show]
  end
  resources :areas, only: [:show] do
    resources :listings
  end
  resource :dashboard, only: [:show]

  root to: "dashboards#show"
end
