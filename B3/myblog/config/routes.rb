Rails.application.routes.draw do
  resources :categories do
    member do
      get 'posts'
    end
  end
  resources :admins do
    collection do
      get 'login'
      post 'check_login'
      get 'signup'
      get 'exit'
    end
  end
  resources :posts do
    resources :comments, only: [:new, :create, :update, :destroy]
    collection do
      get 'search'
    end
  end
  resources :comments, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
