Rails.application.routes.draw do
  root 'vehicles#index'
  resources :vehicles, only: [:index, :create] do
    member do
      post 'update_fuel_efficiency'
    end
  end
end
