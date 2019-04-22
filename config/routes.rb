Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, except: [:index] do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :edit, :update] do
    member do
      get :change_password
      patch :change_password
    end
  end

  resource :session, only: [:new, :create, :destroy]

  get('/', to: 'posts#index', as: 'root')
end
