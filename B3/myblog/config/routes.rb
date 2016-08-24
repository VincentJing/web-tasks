Rails.application.routes.draw do
  resources :categories do
    member do
      get 'show_post_by_category'
    end
  end
  resources :admins do
    collection do
      get 'login'
      post 'check_login'
      get 'signup'
    end
  end
  resources :posts do
    resources :comments, only: [:new, :create, :update, :destroy]
  end
  resources :comments, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
