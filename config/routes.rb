Rails.application.routes.draw do
  # config/routes.rb
  devise_for :admins, controllers: {sessions: 'admins/sessions',registrations: 'admins/registrations'}
  devise_for :users, controllers: {sessions: 'users/sessions',registrations: 'users/registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "homes#about"
  get "top", to: "homes#top", as: "top"

  namespace :public do
    get 'search', to: 'searches#search', as: 'search'
    get 'users/withdraw', to: 'users#withdraw_confirm', as: 'withdraw_confirm'
    delete 'users/withdraw', to: 'users#destroy', as: 'withdraw'
    resources :users, only: [:index, :edit, :show, :update, :destroy]do
      resource :follow, only: [:create, :destroy]
    end

    resources :posts, only: [:new, :index, :show, :create, :destroy] do
      resources :reviews, only: [:index, :new, :create, :destroy]
      resources :post_likes, only: [:create, :destroy]
      resources :comments, only: [:index, :create, :destroy] do
        resources :comment_likes, only: [:create, :destroy]
      end
    end
    
    resources :notifications, only: [:index] do
      member do
        patch :mark_as_read
      end
      collection do
        patch :mark_all_as_read
      end
    end

    resources :categories, only: [:new, :edit, :create, :update, :destroy]
    resources :expenses, only: [:edit, :create, :update, :destroy]
    resources :periods, only: [:index, :show, :edit, :create, :update, :destroy]
  end

  namespace :admins do
    get 'homes/top' => 'homes#top', as: 'root'
    resources :users, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :destroy]
    resources :reviews, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
  end
end
