Rails.application.routes.draw do
  root 'vehicles#index'
  resources :vehicles, only: [:index, :create]
end
