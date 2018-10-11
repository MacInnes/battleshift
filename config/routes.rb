Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#show"
  namespace :api do
    namespace :v1 do
      resources :games, only: [:show] do
        post "/shots", to: "games/shots#create"
      end

      resources :users, only: [:index, :show]
      patch '/users/:id', to: 'users#update'
    end
  end

  resources :users, only: [:create, :show, :index, :edit, :update]

  get '/register', to: "users#new"
  get '/dashboard', to: "dashboard#show"
end
