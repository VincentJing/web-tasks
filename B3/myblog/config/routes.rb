Rails.application.routes.draw do
  resources :categories
  resources :admins do
    collection do
      get 'login'
      post 'check_login'
      get 'signup'
    end
  end
  resources :posts do
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
