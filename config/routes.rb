Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'

  get 'home/about', to: 'homes#about'

  resources :books , only: [:create, :index, :show, :edit, :index, :update , :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users , only: [:show, :edit, :update, :edit, :index] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member # 追加
    get :followers, on: :member # 追加
  end
end