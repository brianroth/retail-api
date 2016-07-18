Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
      resources :locations, only: [:index, :create, :show, :update, :destroy]
      resources :items, only: [:index, :create, :show, :update, :destroy]
      resources :hierarchy_nodes, only: [:index, :create, :show, :update, :destroy]  do
        resources :items, only: :index
      end
      resources :brands, only: [:index, :create, :show, :update, :destroy] do
        resources :items, only: :index
      end

      resources :sessions, only: [:create]
    end
  end
end
