Rails.application.routes.draw do
    root to: 'toppages#index'
  
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    get 'sign-up', to: 'users#new'
    resources :users, only: [:show, :create] do
        member do
            get :likes
        end
    end
    
    
    resources :posts, only: [:create, :destroy, :new] do
        collection do
            get :relax
            get :sad
            get :tired
        end
    end
    resources :favorites, only: [:create, :destroy]
end
