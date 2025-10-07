Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "homes#top"
  get "about", to: "homes#about", as: "about"

  namespace :public do
    get 'search', to: 'searches#search', as: 'search'
    get "mypage", to: "users#mypage", as: "mypage"
    resources :users, only: [:index, :edit, :show, :update, :destroy]
    resources :posts, :reviews, only: [:new, :index, :show, :create, :destroy]
    resources :comments, :likes, only: [:index, :create, :destroy]
    resources :follows, only: [:create, :destroy]
    resources :notifications, only: [:index, :update, :destroy]
    resources :categories, only: [:index, :create, :update, :destroy]
    resources :expenses, only: [:create, :update, :destroy]
    resources :histories, only: [:index, :destroy]
  end

  namespace :admin do
    resources :users, :posts, :comments, :reviews, only: [:destroy]
  end
end
