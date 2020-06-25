Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'

  get 'home/about', to: 'homes#about'

  resources :books , only: [:create, :index, :show, :edit, :index, :update , :destroy]
  resources :users , only: [:show, :edit, :update, :edit, :index]
end