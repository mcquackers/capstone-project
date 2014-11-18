Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :areas, only: [:show] do
    resource :marketplace, only: [:show] do
      resources :listings, only: [:show, :new, :create,
                                  :edit, :update, :destroy]
    end
  end
  resources :dashboards, only: [:index]

  root to: "dashboards#index"
end
