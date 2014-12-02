Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show] do
    resources :notifications, only: [:index]
    resource :club_list, only: [:show]
    resources :buddy_relationships, only: [:create, :destroy, :update]
    resources :status_entries, only: [:create]
    resource :marketplace, only: [:show]
  end
  resources :areas, only: [:show] do
    resources :clubs, only: [:index, :new, :create, :show]
    resources :listings
    resources :courses, only: [:new, :index, :create, :show]
  end
  resources :courses, only: [] do
    resources :course_times, only: [:create, :index]
  end
  resources :clubs, only: [] do
    resources :club_memberships, only: [:create, :destroy]
  end
  resource :dashboard, only: [:show]

  root to: "dashboards#show"
end
