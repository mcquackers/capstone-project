Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show] do
    resources :status_entries, only: [:create]
    resource :marketplace, only: [:show]
  end
  resources :areas, only: [:show] do
    resources :clubs, only: [:index, :new, :create, :show]
    resources :listings
  end
  resources :clubs, only: [] do
    resources :club_memberships, only: [:create, :destroy]
  end
  resource :dashboard, only: [:show]

  root to: "dashboards#show"
end
