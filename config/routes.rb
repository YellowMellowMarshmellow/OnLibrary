Rails.application.routes.draw do
  devise_for :users
  root to: "books#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :books do
    collection do
      get :search
    end

    # Nested route of rentals under a book
    resources :rentals, only: [:create, :update]
  end

  # Separate route for rentals#index to show all rentals of current user:
  resources :rentals, only: [:index]
end
