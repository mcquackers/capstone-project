Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resource :guest, only: [:show]

  root to: "guests#show"
end
