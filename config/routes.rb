# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  root 'users#index'

  namespace :api , defaults: { format: :json } do
    namespace :v1 do
      post 'users/sign_up' => 'users#register'
      post 'users/sign_in' => 'users#login'
      get 'posts' => 'posts#index'
      post 'posts/create' => 'posts#create'
      get 'comments' => 'comments#index'
      post 'comments/create' => 'comments#create'
    end
  end

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: %i[new create]
    end
  end

  # get 'users', to: 'users#index'
  # get 'users/:user_id', to: 'users#show'
  # get 'users/:user_id/posts', to: 'posts#index'
  # get 'users/:user_id/posts/:id', to: 'posts#show'
end
